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
  final ClienteServiceAbs _clienteService;
  int nextPage;

  ListasCitaBloc(
      {required ClienteServiceAbs clienteService, required this.nextPage})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ListasCitaState()) {
    on<EventListaCitasCliente>(onClienteCitas,
        transformer: throttleDroppableCita(throttleDurationCita));
  }

  Future<void> onClienteCitas(
      EventListaCitasCliente event, Emitter<ListasCitaState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ListasCitaStatus.initial) {
      final clienteCitas = await _clienteService.getClienteCitas();

      if (clienteCitas[1] && clienteCitas[0].totalPages > 1) {
        return emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: false));
      } else if (clienteCitas[1] && clienteCitas[0].totalPages == 1) {
        return emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: true));
      } else {
        return emit(state.copyWith(
            status: ListasCitaStatus.failure, error: clienteCitas[0]));
      }
    }

    nextPage += 1;
    final clienteCitas = await _clienteService.getClienteCitas(nextPage);

    if (clienteCitas[1] && nextPage < clienteCitas[0].totalPages) {
      if (nextPage < clienteCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: List.of(state.response)..addAll(clienteCitas[0].content),
            hasReachedMax: false));
      } else if (nextPage == clienteCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: List.of(state.response)..addAll(clienteCitas[0].content),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
