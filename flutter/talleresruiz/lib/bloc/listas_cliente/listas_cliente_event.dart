part of 'listas_cliente_bloc.dart';

abstract class ListasClienteEvent extends Equatable {
  const ListasClienteEvent();

  @override
  List<Object> get props => [];
}

class EventListaClientes extends ListasClienteEvent {}
