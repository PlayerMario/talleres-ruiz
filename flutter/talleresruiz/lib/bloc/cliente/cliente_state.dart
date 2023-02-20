part of 'cliente_bloc.dart';

enum ClienteStatus { initial, success, failure }

// SI NO FUNCIONA, VOLVER A CREAR EL BLOC CLIENTE_CITAS_BLOC CON SU ESTADO Y EVENT DE ABAJO

class ClienteState extends Equatable {
  const ClienteState(
      {this.status = ClienteStatus.initial,
      this.response,
      this.hasReachedMax = false});

  final ClienteStatus status;
  final dynamic response;
  final bool hasReachedMax;

  ClienteState copyWith(
      {ClienteStatus? status, dynamic response, bool? hasReachedMax}) {
    return ClienteState(
        status: status ?? this.status,
        response: response ?? this.response,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  List<Object> get props => [];
}

/*
  part of 'cliente_citas_bloc.dart';

enum ClienteCitasStatus { initial, success, failure }

class ClienteCitasState extends Equatable {
  const ClienteCitasState(
      {this.status = ClienteCitasStatus.initial,
      this.clienteCitas,
      this.hasReachedMax = false});

  final ClienteCitasStatus status;
  final dynamic clienteCitas;
  final bool hasReachedMax;

  ClienteCitasState copyWith(
      {ClienteCitasStatus? status,
      dynamic clienteCitas,
      bool? hasReachedMax/*,
      int? page*/}) {
    return ClienteCitasState(
        status: status ?? this.status,
        clienteCitas: clienteCitas ?? this.clienteCitas,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  /*@override
  String toString() {
    return '''ClienteCitasState { status: $status, hasReachedMax: $hasReachedMax, clienteCitas: $clienteCitas }''';
  }*/

  @override
  List<Object> get props => [/*status, clienteCitas!, hasReachedMax*/];
}

*/
