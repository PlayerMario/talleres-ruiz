import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_cita_state.dart';
part 'listas_cita_event.dart';

const throttleDurationCita = Duration(milliseconds: 1000);
EventTransformer<E> throttleDroppableCita<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasCitaBloc extends Bloc<ListasCitaEvent, ListasCitaState> {
  final ClienteServiceAbs _clienteService;

  ListasCitaBloc({required ClienteServiceAbs clienteService})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ListasCitaState()) {
    on<EventListaCitasCliente>(onClienteCitas,
        transformer: throttleDroppableCita(throttleDurationCita));
  }

  Future<void> onClienteCitas(
      EventListaCitasCliente event, Emitter<ListasCitaState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ClienteStatus.initial) {
      //await Future.delayed(const Duration(milliseconds: 500));
      final clienteCitas = await _clienteService.getClienteCitas();

      if (clienteCitas[1]) {
        return emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: false));
      } else {
        return emit(state.copyWith(
            status: ListasCitaStatus.failure, response: clienteCitas[0]));
      }
    }

    //await Future.delayed(const Duration(milliseconds: 500));
    final clienteCitas =
        await _clienteService.getClienteCitas(state.response.length);

    clienteCitas[0].content.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(
            status: ListasCitaStatus.success,
            response: List.of(state.response)..addAll(clienteCitas[0].content),
            hasReachedMax: false));
  }
}
