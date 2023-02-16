import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../main.dart';

part './crear_cliente_event.dart';
part './crear_cliente_state.dart';

class CrearClienteBloc extends Bloc<CrearClienteEvent, CrearClienteState> {
  CrearClienteBloc({required CrearClienteBody cliente})
      : super(const CrearClienteState()) {
    on<CrearClienteFetched>(onCrearClienteFetched);
  }

  Future<void> onCrearClienteFetched(
      CrearClienteFetched event, Emitter<CrearClienteState> emit) async {
    try {
      if (state.status == CrearClienteStatus.initial) {
        final clienteCreado = await crearCliente(event.cliente);
        return emit(state.copyWith(
            status: CrearClienteStatus.success, clienteCreado: clienteCreado));
      }
    } catch (_) {
      emit(state.copyWith(status: CrearClienteStatus.failure));
    }
  }
}
