part of 'cliente_editar_bloc.dart';

enum ClienteEditarStatus { initial, success, failure }

class ClienteEditarState extends Equatable {
  const ClienteEditarState(
      {this.status = ClienteEditarStatus.initial, this.clienteEditado});

  final ClienteEditarStatus status;
  final dynamic clienteEditado;

  ClienteEditarState copyWith(
      {ClienteEditarStatus? status, dynamic clienteEditado}) {
    return ClienteEditarState(
        status: status ?? this.status,
        clienteEditado: clienteEditado ?? this.clienteEditado);
  }

  @override
  List<Object> get props => [];
}
