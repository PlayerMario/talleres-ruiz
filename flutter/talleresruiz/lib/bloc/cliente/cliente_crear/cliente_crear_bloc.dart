import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../main.dart';

part 'cliente_crear_event.dart';
part 'cliente_crear_state.dart';

class ClienteCrearBloc extends Bloc<ClienteCrearEvent, ClienteCrearState> {
  ClienteCrearBloc({required ClienteCrearBody cliente})
      : super(const ClienteCrearState()) {
        //crearClienteRepo = GetIt.I.get<CrearClienteRepository>();
        _clienteRepo = GetIt.I.get<ClienteRepository>();
    on<ClienteCrearFetched>(onCrearClienteFetched);
  }

  //late CrearClienteRepository crearClienteRepo;
  late ClienteRepository _clienteRepo;

  Future<void> onCrearClienteFetched(
      ClienteCrearFetched event, Emitter<ClienteCrearState> emit) async {
    if (state.status == ClienteCrearStatus.initial) {
      //final clienteCreado = await crearClienteRepo.crearCliente(event.cliente);
      final clienteCreado = await _clienteRepo.crearCliente(event.cliente);
      
      if (clienteCreado[1]) {
        return emit(state.copyWith(
            status: ClienteCrearStatus.success,
            clienteCreado: clienteCreado[0]));
      } else {
        return emit(state.copyWith(
            status: ClienteCrearStatus.failure,
            clienteCreado: clienteCreado[0]));
      }
    }
  }
}
