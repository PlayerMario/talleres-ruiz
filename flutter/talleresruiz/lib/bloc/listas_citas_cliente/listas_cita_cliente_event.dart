part of 'listas_cita_cliente_bloc.dart';

abstract class ListasCitaClienteEvent extends Equatable {
  const ListasCitaClienteEvent();

  @override
  List<Object> get props => [];
}

class EventListaCitasCliente extends ListasCitaClienteEvent {}
