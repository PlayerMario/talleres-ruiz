part of 'listas_cita_bloc.dart';

enum ListasCitaStatus { initial, success, failure }

class ListasCitaState extends Equatable {
  const ListasCitaState(
      {this.status = ListasCitaStatus.initial,
      this.response = const <CitaListaResponse>[],
      this.error,
      this.hasReachedMax = false});

  final ListasCitaStatus status;
  final List<CitaListaResponse> response;
  final dynamic error;
  final bool hasReachedMax;

  ListasCitaState copyWith(
      {ListasCitaStatus? status,
      List<CitaListaResponse>? response,
      dynamic error,
      bool? hasReachedMax}) {
    return ListasCitaState(
        status: status ?? this.status,
        response: response ?? this.response,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''ListasCitaState { status: $status, hasReachedMax: $hasReachedMax, citas: ${response.length} }''';
  }

  @override
  List<Object> get props => [status, response, hasReachedMax];
}
