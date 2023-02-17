import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../main.dart';

part './crear_cliente_event.dart';
part './crear_cliente_state.dart';

class CrearClienteBloc extends Bloc<CrearClienteEvent, CrearClienteState> {
  CrearClienteBloc({required CrearClienteBody cliente})
      : super(const CrearClienteState()) {
        crearClienteRepo = GetIt.I.get<CrearClienteRepository>();
    on<CrearClienteFetched>(onCrearClienteFetched);
  }

  late CrearClienteRepository crearClienteRepo;

  Future<void> onCrearClienteFetched(
      CrearClienteFetched event, Emitter<CrearClienteState> emit) async {
    if (state.status == CrearClienteStatus.initial) {
      final clienteCreado = await crearClienteRepo.crearCliente(event.cliente);
      
      if (clienteCreado[1]) {
        return emit(state.copyWith(
            status: CrearClienteStatus.success,
            clienteCreado: clienteCreado[0]));
      } else {
        return emit(state.copyWith(
            status: CrearClienteStatus.failure,
            clienteCreado: clienteCreado[0]));
      }
    }
  }
}
