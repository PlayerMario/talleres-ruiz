import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talleresruiz/crear_cliente/crear_cliente.dart';

part './crear_cliente_event.dart';
part './crear_cliente_state.dart';

class CrearClienteBloc extends Bloc<CrearClienteEvent, CrearClienteState> {
  CrearClienteBloc() : super(const CrearClienteState()) {
    on<CrearClienteFetched>(onCrearClienteFetched);
  }

  Future<void> onCrearClienteFetched(
      CrearClienteFetched event, Emitter<CrearClienteState> emit) async {
    try {
      if (state.status == CrearClienteStatus.initial) {
        final clienteCreado = await buscarClienteCreado(
            event.username,
            event.password,
            event.passwordVerify,
            event.dni,
            event.nombre,
            event.fechaNacimiento,
            event.email,
            event.tlf,
            event.vehiculo,
            event.matricula);
        return emit(state.copyWith(
            status: CrearClienteStatus.success, clienteCreado: clienteCreado));
      }
    } catch (_) {
      emit(state.copyWith(status: CrearClienteStatus.failure));
    }
  }
}
