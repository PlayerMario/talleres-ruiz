part of 'cita_bloc.dart';

abstract class CitaEvent extends Equatable {
  const CitaEvent();

  @override
  List<Object> get props => [];
}

class EventCitaDetalles extends CitaEvent {
  const EventCitaDetalles(this.id);

  final int id;
}

class EventCrearCitaCliente extends CitaEvent {
  const EventCrearCitaCliente(this.cita);

  final CitaCrearClienteBody cita;
}

class EventCrearCitaAdMec extends CitaEvent {
  const EventCrearCitaAdMec(this.cita);

  final CitaCrearAdMecBody cita;
}

class EventEditarCitaCliente extends CitaEvent {
  const EventEditarCitaCliente(this.cita, this.id);

  final CitaCrearClienteBody cita;
  final int id;
}

class EventBorrarCitaCliente extends CitaEvent {
  const EventBorrarCitaCliente(this.id);

  final int id;
}
