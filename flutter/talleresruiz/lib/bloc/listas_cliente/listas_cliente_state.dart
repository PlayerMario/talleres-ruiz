part of 'listas_cliente_bloc.dart';

enum ListasClienteStatus { initial, success, failure }

class ListasClienteState extends Equatable {
  const ListasClienteState(
      {this.status = ListasClienteStatus.initial,
      this.response = const <ClienteListaResponse>[],
      this.error,
      this.hasReachedMax = false});

  final ListasClienteStatus status;
  final List<ClienteListaResponse> response;
  final dynamic error;
  final bool hasReachedMax;

  ListasClienteState copyWith(
      {ListasClienteStatus? status,
      List<ClienteListaResponse>? response,
      dynamic error,
      bool? hasReachedMax}) {
    return ListasClienteState(
        status: status ?? this.status,
        response: response ?? this.response,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''ListasClienteState { status: $status, hasReachedMax: $hasReachedMax, clientes: ${response.length} }''';
  }

  @override
  List<Object> get props => [status, response, hasReachedMax];
}
