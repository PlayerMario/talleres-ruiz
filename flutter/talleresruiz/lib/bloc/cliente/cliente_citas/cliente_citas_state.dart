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
      bool? hasReachedMax,
      int? page}) {
    return ClienteCitasState(
        status: status ?? this.status,
        clienteCitas: clienteCitas ?? this.clienteCitas,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  /*@override
  String toString() {
    return '''ClienteCitasState { status: $status, hasReachedMax: $hasReachedMax, clienteCitas: ${clienteCitas.content.length} }''';
  }*/

  @override
  List<Object> get props => [/*status, clienteCitas, hasReachedMax*/];
}
