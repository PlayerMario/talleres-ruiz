import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_cliente_state.dart';
part 'listas_cliente_event.dart';

const throttleDurationCliente = Duration(milliseconds: 1500);
EventTransformer<E> throttleDroppableCliente<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasClienteBloc extends Bloc<ListasClienteEvent, ListasClienteState> {
  final ClienteServiceAbs _clienteService;
  int nextPage;

  ListasClienteBloc(
      {required ClienteServiceAbs clienteService, required this.nextPage})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ListasClienteState()) {
    on<EventListaClientes>(onListarClientes,
        transformer: throttleDroppableCliente(throttleDurationCliente));
  }

  Future<void> onListarClientes(
      EventListaClientes event, Emitter<ListasClienteState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ListasClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final listaClientes = await _clienteService.getListaClientes();

      if (listaClientes[1] && listaClientes[0].totalPages > 1) {
        return emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: listaClientes[0].content,
            hasReachedMax: false));
      } else if (listaClientes[1] && listaClientes[0].totalPages == 1) {
        return emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: listaClientes[0].content,
            hasReachedMax: true));
      } else {
        return emit(state.copyWith(
            status: ListasClienteStatus.failure, error: listaClientes[0]));
      }
    }

    nextPage += 1;
    await Future.delayed(const Duration(milliseconds: 500));
    final listaClientes = await _clienteService.getListaClientes(nextPage);

    if (listaClientes[1] && nextPage < listaClientes[0].totalPages) {
      if (nextPage < listaClientes[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: List.of(state.response)..addAll(listaClientes[0].content),
            hasReachedMax: false));
      } else if (nextPage == listaClientes[0].totalPages - 1) {
        emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: List.of(state.response)..addAll(listaClientes[0].content),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
