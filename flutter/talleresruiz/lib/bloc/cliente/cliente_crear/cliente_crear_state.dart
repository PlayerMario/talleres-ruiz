part of 'cliente_crear_bloc.dart';

enum ClienteCrearStatus { initial, success, failure }

class ClienteCrearState extends Equatable {
  const ClienteCrearState(
      {this.status = ClienteCrearStatus.initial, this.clienteCreado});

  final ClienteCrearStatus status;
  final dynamic clienteCreado;

  ClienteCrearState copyWith(
      {ClienteCrearStatus? status, dynamic clienteCreado}) {
    return ClienteCrearState(
        status: status ?? this.status,
        clienteCreado: clienteCreado ?? this.clienteCreado);
  }

  @override
  List<Object> get props => [];
}
