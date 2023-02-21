part of 'listas_cliente_bloc.dart';

enum ListasClienteStatus { initial, success, failure }

class ListasClienteState extends Equatable {
  const ListasClienteState(
      {this.status = ListasClienteStatus.initial,
      this.response,
      this.hasReachedMax = false});

  final ListasClienteStatus status;
  final dynamic response;
  final bool hasReachedMax;

  ListasClienteState copyWith(
      {ListasClienteStatus? status, dynamic response, bool? hasReachedMax}) {
    return ListasClienteState(
        status: status ?? this.status,
        response: response ?? this.response,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  /*@override
  String toString() {
    return '''ListasClienteState { status: $status, hasReachedMax: $hasReachedMax, clientes: $response }''';
  }*/

  @override
  List<Object> get props => [/*status, response.content, hasReachedMax*/];
}
