part of 'listas_cita_bloc.dart';

enum ListasCitaStatus { initial, success, failure }

class ListasCitaState extends Equatable {
  const ListasCitaState(
      {this.status = ListasCitaStatus.initial,
      this.response = const <Citas>[],
      this.hasReachedMax = false});

  final ListasCitaStatus status;
  final List<Citas> response;
  final bool hasReachedMax;

  ListasCitaState copyWith(
      {ListasCitaStatus? status,
      List<Citas>? response,
      bool? hasReachedMax}) {
    return ListasCitaState(
        status: status ?? this.status,
        response: response ?? this.response,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''ListasCitaState { status: $status, hasReachedMax: $hasReachedMax, citas: ${response.length} }''';
  }

  @override
  List<Object> get props => [status, response, hasReachedMax];
}