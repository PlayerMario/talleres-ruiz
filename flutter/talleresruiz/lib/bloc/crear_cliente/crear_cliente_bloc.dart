import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../main.dart';

part './crear_cliente_event.dart';
part './crear_cliente_state.dart';

class CrearClienteBloc extends Bloc<CrearClienteEvent, CrearClienteState> {
  CrearClienteBloc() : super(const CrearClienteState()) {
    crearClienteRepo = GetIt.I.get<CrearClienteRepo>();
    on<CrearClienteFetched>(onCrearClienteFetched);
  }

  late CrearClienteRepo crearClienteRepo;

  Future<void> onCrearClienteFetched(
      CrearClienteFetched event, Emitter<CrearClienteState> emit) async {
    try {
      if (state.status == CrearClienteStatus.initial) {
        final clienteCreado = await crearClienteRepo.crearCliente(
            event.username,
            event.password,
            event.verifyPassword,
            event.dni,
            event.nombre,
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
