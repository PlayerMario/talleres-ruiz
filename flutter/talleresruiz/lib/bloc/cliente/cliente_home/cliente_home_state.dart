part of 'cliente_home_bloc.dart';

enum ClienteHomeStatus { initial, success, failure }

class ClienteHomeState extends Equatable {
  const ClienteHomeState({this.status = ClienteHomeStatus.initial, this.clienteMe});

  final ClienteHomeStatus status;
  final dynamic clienteMe;

  ClienteHomeState copyWith({ClienteHomeStatus? status, dynamic clienteMe}) {
    return ClienteHomeState(
        status: status ?? this.status, clienteMe: clienteMe ?? this.clienteMe);
  }

  @override
  List<Object> get props => [];
}
