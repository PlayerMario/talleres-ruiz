part of 'listas_mecanico_bloc.dart';

enum ListasMecanicoStatus { initial, success, failure }

class ListasMecanicoState extends Equatable {
  const ListasMecanicoState(
      {this.status = ListasMecanicoStatus.initial,
      this.response = const <MecanicoListaResponse>[],
      this.error,
      this.hasReachedMax = false});

  final ListasMecanicoStatus status;
  final List<MecanicoListaResponse> response;
  final dynamic error;
  final bool hasReachedMax;

  ListasMecanicoState copyWith(
      {ListasMecanicoStatus? status,
      List<MecanicoListaResponse>? response,
      dynamic error,
      bool? hasReachedMax}) {
    return ListasMecanicoState(
        status: status ?? this.status,
        response: response ?? this.response,
        error: error ?? this.error,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() {
    return '''ListasMecanicoState { status: $status, hasReachedMax: $hasReachedMax, mecánicos: ${response.length} }''';
  }

  @override
  List<Object> get props => [status, response, hasReachedMax];
}