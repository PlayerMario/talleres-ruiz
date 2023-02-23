import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_cita_cliente_state.dart';
part 'listas_cita_cliente_event.dart';

const throttleDurationCitaCliente = Duration(milliseconds: 1500);
EventTransformer<E> throttleDroppableCitaCliente<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasCitaClienteBloc
    extends Bloc<ListasCitaClienteEvent, ListasCitaClienteState> {
  final ClienteServiceAbs _clienteService;
  int nextPage;

  ListasCitaClienteBloc(
      {required ClienteServiceAbs clienteService, required this.nextPage})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ListasCitaClienteState()) {
    on<EventListaCitasCliente>(onClienteCitas,
        transformer: throttleDroppableCitaCliente(throttleDurationCitaCliente));
  }

  Future<void> onClienteCitas(EventListaCitasCliente event,
      Emitter<ListasCitaClienteState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ListasCitaClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteCitas = await _clienteService.getClienteCitas();

      if (clienteCitas[1] && clienteCitas[0].totalPages > 1) {
        return emit(state.copyWith(
            status: ListasCitaClienteStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: false));
      } else if (clienteCitas[1] && clienteCitas[0].totalPages == 1) {
        return emit(state.copyWith(
            status: ListasCitaClienteStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: true));
      } else {
        return emit(state.copyWith(
            status: ListasCitaClienteStatus.failure, error: clienteCitas[0]));
      }
    }

    nextPage += 1;
    await Future.delayed(const Duration(milliseconds: 500));
    final clienteCitas = await _clienteService.getClienteCitas(nextPage);

    if (clienteCitas[1] && nextPage < clienteCitas[0].totalPages) {
      if (nextPage < clienteCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaClienteStatus.success,
            response: List.of(state.response)..addAll(clienteCitas[0].content),
            hasReachedMax: false));
      } else if (nextPage == clienteCitas[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasCitaClienteStatus.success,
            response: List.of(state.response)..addAll(clienteCitas[0].content),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
