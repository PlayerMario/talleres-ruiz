import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_cita_state.dart';
part 'listas_cita_event.dart';

const throttleDurationCita = Duration(milliseconds: 1500);
EventTransformer<E> throttleDroppableCita<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasCitaBloc extends Bloc<ListasCitaEvent, ListasCitaState> {
  final CitaServiceAbs _citaService;
  int nextPage;

  ListasCitaBloc({required CitaServiceAbs citaService, required this.nextPage})
      : assert(citaService != null),
        _citaService = citaService,
        super(const ListasCitaState()) {
    on<EventListaCitas>(onListarCitas,
        transformer: throttleDroppableCita(throttleDurationCita));
  }

  Future<void> onListarCitas(
      EventListaCitas event, Emitter<ListasCitaState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ListasCitaStatus.initial) {
      final listaCitas = await _citaService.getListaCitas();

      if (listaCitas[1] && listaCitas[0].totalPages > 1) {
        return emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: listaCitas[0].content,
            hasReachedMax: false));
      } else if (listaCitas[1] && listaCitas[0].totalPages == 1) {
        return emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: listaCitas[0].content,
            hasReachedMax: true));
      } else {
        return emit(state.copyWith(
            status: ListasCitaStatus.failure, error: listaCitas[0]));
      }
    }

    nextPage += 1;
    final listaCitas = await _citaService.getListaCitas(nextPage);

    if (listaCitas[1] && nextPage < listaCitas[0].totalPages) {
      if (nextPage < listaCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: List.of(state.response)..addAll(listaCitas[0].content),
            hasReachedMax: false));
      } else if (nextPage == listaCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: List.of(state.response)..addAll(listaCitas[0].content),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
