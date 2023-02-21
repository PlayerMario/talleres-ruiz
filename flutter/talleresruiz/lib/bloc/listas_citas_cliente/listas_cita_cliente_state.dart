part of 'listas_cita_cliente_bloc.dart';

enum ListasCitaClienteStatus { initial, success, failure }

class ListasCitaClienteState extends Equatable {
  const ListasCitaClienteState(
      {this.status = ListasCitaClienteStatus.initial,
      this.response = const <Citas>[],
      this.error,
      this.hasReachedMax = false});

  final ListasCitaClienteStatus status;
  final List<Citas> response;
  final dynamic error;
  final bool hasReachedMax;

  ListasCitaClienteState copyWith(
      {ListasCitaClienteStatus? status,
      List<Citas>? response,
      dynamic error,
      bool? hasReachedMax}) {
    return ListasCitaClienteState(
        status: status ?? this.status,
        response: response ?? this.response,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''ListasCitaClienteState { status: $status, hasReachedMax: $hasReachedMax, citas: ${response.length} }''';
  }

  @override
  List<Object> get props => [status, response, hasReachedMax];
}
