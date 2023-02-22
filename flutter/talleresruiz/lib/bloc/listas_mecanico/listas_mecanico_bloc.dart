import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_mecanico_state.dart';
part 'listas_mecanico_event.dart';

const throttleDurationMecanio = Duration(milliseconds: 1500);
EventTransformer<E> throttleDroppableMecanico<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasMecanicoBloc
    extends Bloc<ListasMecanicoEvent, ListasMecanicoState> {
  final AdMecServiceAbs _adMecService;
  int nextPage;

  ListasMecanicoBloc(
      {required AdMecServiceAbs adMecService, required this.nextPage})
      : assert(adMecService != null),
        _adMecService = adMecService,
        super(const ListasMecanicoState()) {
    on<EventListaMecanicos>(onListarMecanicos,
        transformer: throttleDroppableCliente(throttleDurationMecanio));
  }

  Future<void> onListarMecanicos(
      EventListaMecanicos event, Emitter<ListasMecanicoState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ListasMecanicoStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final listaMecanicos = await _adMecService.getListaMecanicos();

      if (listaMecanicos[1] && listaMecanicos[0].totalPages > 1) {
        return emit(state.copyWith(
            status: ListasMecanicoStatus.success,
            response: listaMecanicos[0].content,
            hasReachedMax: false));
      } else if (listaMecanicos[1] && listaMecanicos[0].totalPages == 1) {
        return emit(state.copyWith(
            status: ListasMecanicoStatus.success,
            response: listaMecanicos[0].content,
            hasReachedMax: true));
      } else {
        return emit(state.copyWith(
            status: ListasMecanicoStatus.failure, error: listaMecanicos[0]));
      }
    }

    nextPage += 1;
    await Future.delayed(const Duration(milliseconds: 500));
    final listaMecanicos = await _adMecService.getListaMecanicos(nextPage);

    if (listaMecanicos[1] && nextPage < listaMecanicos[0].totalPages) {
      if (nextPage < listaMecanicos[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasMecanicoStatus.success,
            response: List.of(state.response)
              ..addAll(listaMecanicos[0].content),
            hasReachedMax: false));
      } else if (nextPage == listaMecanicos[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasMecanicoStatus.success,
            response: List.of(state.response)
              ..addAll(listaMecanicos[0].content),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
