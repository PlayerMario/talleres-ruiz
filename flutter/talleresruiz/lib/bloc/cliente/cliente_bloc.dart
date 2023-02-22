import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../main.dart';

part './cliente_event.dart';
part './cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final ClienteServiceAbs _clienteService;
  late ClienteRepository _clienteRepo;

  ClienteBloc({required ClienteServiceAbs clienteService})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteState()) {
    _clienteRepo = GetIt.I.get<ClienteRepository>();
    on<EventClienteHome>(onMostrarClienteMe);
    on<EventDetallesCliente>(onDetallesCliente);
    on<EventCrearCliente>(onCrearCliente);
    on<EventEditarCliente>(onEditarCliente);
    on<EventBorrarCliente>(onBorrarCliente);
    on<EventBorrarClienteAdMec>(onBorrarClienteAdMec);
    on<EventLogoutCliente>(onLogoutCliente);
  }

  Future<void> onMostrarClienteMe(
      EventClienteHome event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteMe = await _clienteService.getClienteLogin();

      if (clienteMe[1]) {
        return emit(state.copyWith(
            response: clienteMe[0], status: ClienteStatus.success));
      } else {
        return emit(state.copyWith(
            response: clienteMe[0], status: ClienteStatus.failure));
      }
    }
  }

  Future<void> onDetallesCliente(
      EventDetallesCliente event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final cliente = await _clienteService.getDetallesCliente(event.id);

      if (cliente[1]) {
        return emit(state.copyWith(
            response: cliente[0], status: ClienteStatus.success));
      } else {
        return emit(state.copyWith(
            response: cliente[0], status: ClienteStatus.failure));
      }
    }
  }

  Future<void> onCrearCliente(
      EventCrearCliente event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteCreado = await _clienteRepo.crearCliente(event.cliente);

      if (clienteCreado[1]) {
        return emit(state.copyWith(
            status: ClienteStatus.success, response: clienteCreado[0]));
      } else {
        return emit(state.copyWith(
            status: ClienteStatus.failure, response: clienteCreado[0]));
      }
    }
  }

  Future<void> onEditarCliente(
      EventEditarCliente event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteEditado = await _clienteService.putCliente(event.cliente);

      if (clienteEditado[1]) {
        return emit(state.copyWith(
            response: clienteEditado[0], status: ClienteStatus.success));
      } else {
        return emit(state.copyWith(
            response: clienteEditado[0], status: ClienteStatus.failure));
      }
    }
  }

  Future<void> onBorrarCliente(
      EventBorrarCliente event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final cliente = await _clienteService.delCliente();

      if (cliente[1]) {
        return emit(state.copyWith(
            response: cliente[0], status: ClienteStatus.success));
      } else {
        return emit(state.copyWith(
            response: cliente[0], status: ClienteStatus.failure));
      }
    }
  }

  Future<void> onBorrarClienteAdMec(
      EventBorrarClienteAdMec event, Emitter<ClienteState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _clienteService.delClienteAdMec(event.id);
    emit(const ClienteState());
  }

  Future<void> onLogoutCliente(
      EventLogoutCliente event, Emitter<ClienteState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _clienteService.clienteLogout();
    emit(const ClienteState());
  }
}
