import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talleresruiz/services/authentication/authentication_service.dart';

part './vista_cliente_event.dart';
part './vista_cliente_state.dart';

class VistaClienteBloc extends Bloc<VistaClienteEvent, VistaClienteState> {
  final AuthenticationService _authenticationService;

  VistaClienteBloc({required AuthenticationService authenticationService})
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(const VistaClienteState()) {
    on<VistaClienteFetched>(onMostrarClienteMe);
  }

  Future<void> onMostrarClienteMe(
      VistaClienteFetched event, Emitter<VistaClienteState> emit) async {
    if (state.status == VistaClienteStatus.initial) {
      await Future.delayed(Duration(milliseconds: 500));
      final clienteMe = await _authenticationService.getCurrentUserCliente();

      if (clienteMe[1]) {
        return emit(state.copyWith(clienteMe: clienteMe[0], status: VistaClienteStatus.success));
      } else {
        return emit(state.copyWith(clienteMe: clienteMe[0], status: VistaClienteStatus.failure));
      }
    }
  }
}
