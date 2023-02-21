part of 'listas_mecanico_bloc.dart';

abstract class ListasMecanicoEvent extends Equatable {
  const ListasMecanicoEvent();

  @override
  List<Object> get props => [];
}

class EventListaMecanicos extends ListasMecanicoEvent {}
