part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

class EventClienteHome extends ClienteEvent {}

/*class EventCitasCliente extends ClienteEvent {}

class EventListarClientes extends ClienteEvent {}*/

class EventCrearCliente extends ClienteEvent {
  const EventCrearCliente(this.cliente);

  final ClienteCrearBody cliente;
}

class EventEditarCliente extends ClienteEvent {
  const EventEditarCliente(this.cliente);

  final ClienteEditarBody cliente;
}

class EventBorrarCliente extends ClienteEvent {}

class EventLogoutCliente extends ClienteEvent {}



/**
 * 
 * part of 'cliente_citas_bloc.dart';

abstract class ClienteCitasEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClienteCitasFetched extends ClienteCitasEvent {}

 */
