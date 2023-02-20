import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

part './cliente_home_event.dart';
part './cliente_home_state.dart';

class ClienteHomeBloc extends Bloc<ClienteHomeEvent, ClienteHomeState> {
  final ClienteServiceAbs _clienteService;

  ClienteHomeBloc({required ClienteServiceAbs clienteService, ClienteEditarBody? cliente})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteHomeState()) {
    on<ClienteHomeFetched>(onMostrarClienteMe);
    on<ClienteEditarFetched>(onEditarCliente);
  }

  Future<void> onMostrarClienteMe(
      ClienteHomeFetched event, Emitter<ClienteHomeState> emit) async {
    if (state.status == ClienteHomeStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteMe = await _clienteService.getClienteLogin();

      if (clienteMe[1]) {
        return emit(state.copyWith(
            clienteMe: clienteMe[0], status: ClienteHomeStatus.success));
      } else {
        return emit(state.copyWith(
            clienteMe: clienteMe[0], status: ClienteHomeStatus.failure));
      }
    }
  }

  Future<void> onEditarCliente(
      ClienteEditarFetched event, Emitter<ClienteHomeState> emit) async {
    if (state.status == ClienteHomeStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final clienteEditado = await _clienteService.putCliente(event.cliente);

      if (clienteEditado[1]) {
        return emit(state.copyWith(
            clienteMe: clienteEditado[0],
            status: ClienteHomeStatus.success));
      } else {
        return emit(state.copyWith(
            clienteMe: clienteEditado[0],
            status: ClienteHomeStatus.failure));
      }
    }
  }
}
