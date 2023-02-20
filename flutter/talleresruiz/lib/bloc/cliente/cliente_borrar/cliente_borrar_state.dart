part of 'cliente_borrar_bloc.dart';

enum ClienteBorrarStatus { initial, success, failure }

class ClienteBorrarState extends Equatable {
  const ClienteBorrarState(
      {this.status = ClienteBorrarStatus.initial, this.resp});

  final ClienteBorrarStatus status;
  final dynamic resp;

  ClienteBorrarState copyWith(
      {ClienteBorrarStatus? status, dynamic resp}) {
    return ClienteBorrarState(
        status: status ?? this.status, resp: resp ?? this.resp);
  }

  @override
  List<Object> get props => [];
}
