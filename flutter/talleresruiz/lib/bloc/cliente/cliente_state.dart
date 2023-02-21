part of 'cliente_bloc.dart';

enum ClienteStatus { initial, success, failure }

class ClienteState extends Equatable {
  const ClienteState({this.status = ClienteStatus.initial, this.response});

  final ClienteStatus status;
  final dynamic response;

  ClienteState copyWith({ClienteStatus? status, dynamic response}) {
    return ClienteState(
        status: status ?? this.status, response: response ?? this.response);
  }

  @override
  List<Object> get props => [];
}
