part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];
}

class EventClienteHome extends ClienteEvent {}

class EventDetallesCliente extends ClienteEvent {
  const EventDetallesCliente(this.id);

  final String id;
}

class EventCrearCliente extends ClienteEvent {
  const EventCrearCliente(this.cliente);

  final ClienteCrearBody cliente;
}

class EventEditarCliente extends ClienteEvent {
  const EventEditarCliente(this.cliente);

  final ClienteEditarBody cliente;
}

class EventBorrarCliente extends ClienteEvent {}

class EventBorrarClienteAdMec extends ClienteEvent {
  const EventBorrarClienteAdMec(this.id);

  final String id;
}

class EventLogoutCliente extends ClienteEvent {}
