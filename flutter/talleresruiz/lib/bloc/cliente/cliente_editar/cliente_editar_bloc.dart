import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part './cliente_editar_event.dart';
part './cliente_editar_state.dart';

class ClienteEditarBloc extends Bloc<ClienteEditarEvent, ClienteEditarState> {
  final ClienteServiceAbs _clienteService;

  ClienteEditarBloc({required ClienteServiceAbs clienteService, required ClienteEditarBody cliente})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteEditarState()) {
    on<ClienteEditarFetch>(onEditarCliente);
  }

  Future<void> onEditarCliente(
      ClienteEditarFetch event, Emitter<ClienteEditarState> emit) async {
        if(state.status == ClienteEditarStatus.initial) {
          await Future.delayed(const Duration(milliseconds: 500));
          final clienteEditado = await _clienteService.putCliente(event.cliente);

          if (clienteEditado[1]) {
        return emit(state.copyWith(clienteEditado: clienteEditado[0], status: ClienteEditarStatus.success));
      } else {
        return emit(state.copyWith(clienteEditado: clienteEditado[0], status: ClienteEditarStatus.failure));
      }
        }
      }
}
