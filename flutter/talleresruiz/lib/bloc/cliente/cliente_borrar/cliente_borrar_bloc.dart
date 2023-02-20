import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../main.dart';

part './cliente_borrar_event.dart';
part './cliente_borrar_state.dart';

class ClienteBorrarBloc extends Bloc<ClienteBorrarEvent, ClienteBorrarState> {
  final ClienteServiceAbs _clienteService;

  ClienteBorrarBloc(
      {required ClienteServiceAbs clienteService, ClienteEditarBody? cliente})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteBorrarState()) {
    on<ClienteBorrarFetched>(onMostrarClienteMe);
  }

  Future<void> onMostrarClienteMe(
      ClienteBorrarFetched event, Emitter<ClienteBorrarState> emit) async {
    if (state.status == ClienteBorrarStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final cliente = await _clienteService.delCliente();

      if (cliente[1]) {
        return emit(state.copyWith(
            resp: cliente[0], status: ClienteBorrarStatus.success));
      } else {
        return emit(state.copyWith(
            resp: cliente[0], status: ClienteBorrarStatus.failure));
      }
    }
  }
}
