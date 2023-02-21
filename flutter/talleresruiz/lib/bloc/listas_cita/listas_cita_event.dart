part of 'listas_cita_bloc.dart';

abstract class ListasCitaEvent extends Equatable {
  const ListasCitaEvent();

  @override
  List<Object> get props => [];
}

class EventListaCitasCliente extends ListasCitaEvent {}
