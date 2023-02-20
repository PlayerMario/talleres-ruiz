import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part './cliente_event.dart';
part './cliente_state.dart';

const throttleDuration = Duration(milliseconds: 1000);
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final ClienteServiceAbs _clienteService;
  late ClienteRepository _clienteRepo;

  ClienteBloc({required ClienteServiceAbs clienteService})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteState()) {
    _clienteRepo = GetIt.I.get<ClienteRepository>();
    on<EventClienteHome>(onMostrarClienteMe);
    on<EventCitasCliente>(onClienteCitas,
        transformer: throttleDroppable(throttleDuration));
    on<EventCrearCliente>(onCrearCliente);
    on<EventEditarCliente>(onEditarCliente);
    on<EventBorrarCliente>(onBorrarCliente);
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

  Future<void> onClienteCitas(
      EventCitasCliente event, Emitter<ClienteState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == ClienteStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteCitas = await _clienteService.getClienteCitas();

      if (clienteCitas[1]) {
        return emit(state.copyWith(
            status: ClienteStatus.success,
            response: clienteCitas[0].content,
            hasReachedMax: false));
      } else {
        return emit(state.copyWith(
            status: ClienteStatus.failure, response: clienteCitas[0]));
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));
    final clienteCitas =
        await _clienteService.getClienteCitas(state.response[0].content.length);

    clienteCitas[0].content.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(
            status: ClienteStatus.success,
            response: List.of(state.response[0].content)
              ..addAll(clienteCitas[0].content),
            hasReachedMax: false));
  }

  Future<void> onCrearCliente(
      EventCrearCliente event, Emitter<ClienteState> emit) async {
    if (state.status == ClienteStatus.initial) {
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

  Future<void> onLogoutCliente(
      EventLogoutCliente event, Emitter<ClienteState> emit) async {
    await _clienteService.clienteLogout();
    emit(const ClienteState());
  }
}



/**
 * 
 * import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part './cliente_citas_event.dart';
part './cliente_citas_state.dart';

const throttleDuration = Duration(milliseconds: 1000);
//int newPage = 0;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ClienteCitasBloc extends Bloc<ClienteCitasEvent, ClienteCitasState> {
  final ClienteServiceAbs _clienteService;

  ClienteCitasBloc({required ClienteServiceAbs clienteService})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteCitasState()) {
    on<ClienteCitasFetched>(onClienteCitas,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> onClienteCitas(
      ClienteCitasFetched event, Emitter<ClienteCitasState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == ClienteCitasStatus.initial) {
      //newPage += 1;

      await Future.delayed(const Duration(milliseconds: 500));

      final clienteCitas = await _clienteService.getClienteCitas();

      if (clienteCitas[1]) {
        return emit(state.copyWith(
            status: ClienteCitasStatus.success,
            clienteCitas: clienteCitas[0].content,
            hasReachedMax: false));
      } else {
        return emit(state.copyWith(
            status: ClienteCitasStatus.failure, clienteCitas: clienteCitas[0]));
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));

    final clienteCitas = await _clienteService.getClienteCitas(/*newPage*/state.clienteCitas[0].content.length);
    clienteCitas[0].content.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(status: ClienteCitasStatus.success, clienteCitas: List.of(state.clienteCitas[0].content)..addAll(clienteCitas[0].content), hasReachedMax: false));
  }
}
 * 
 */