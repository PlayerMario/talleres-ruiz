import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'listas_cliente_state.dart';
part 'listas_cliente_event.dart';

const throttleDurationCliente = Duration(milliseconds: 1000);
EventTransformer<E> throttleDroppableCliente<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ListasClienteBloc extends Bloc<ListasClienteEvent, ListasClienteState> {
  final ClienteServiceAbs _clienteService;
  int newPage;

  ListasClienteBloc(
      {required ClienteServiceAbs clienteService, required this.newPage})
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
      final listaClientes = await _clienteService.getListaClientes();

      if (listaClientes[1]) {
        return emit(state.copyWith(
            status: ListasClienteStatus.success,
            //response: listaClientes[0].content,
            response: listaClientes[0],
            hasReachedMax: false));
      } else {
        return emit(state.copyWith(
            status: ListasClienteStatus.failure, response: listaClientes[0]));
      }
    }

    newPage += 1;
    final listaClientes = await _clienteService.getListaClientes(newPage);

    if (listaClientes[1]) {
      List<dynamic> listado = state.response!.content!;
      if (newPage < state.response!.totalPages!) {
        listado.addAll(listaClientes[0].content);
        emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: listado,
            hasReachedMax: false));
      } else if (newPage == state.response!.totalPages!) {
        emit(state.copyWith(
            status: ListasClienteStatus.success,
            response: List.of(state.response!.content!)
              ..addAll(listaClientes[0].content!),
            hasReachedMax: true));
      }
    } else {
      emit(state.copyWith(hasReachedMax: true));
    }
  }
}
