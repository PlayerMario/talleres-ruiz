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

class EventEditarCitaAdMec extends CitaEvent {
  const EventEditarCitaAdMec(this.cita, this.id);

  final CitaEditarAdMecBody cita;
  final int id;
}

class EventBorrarCitaCliente extends CitaEvent {
  const EventBorrarCitaCliente(this.id);

  final int id;
}

class EventBorrarCitaAdMec extends CitaEvent {
  const EventBorrarCitaAdMec(this.id);

  final int id;
}

class EventAgregarMsj extends CitaEvent {
  const EventAgregarMsj(this.adjunto, this.id);

  final AdjuntoMsjBody adjunto;
  final int id;
}

class EventCitaBorrarAdj extends CitaEvent {
  const EventCitaBorrarAdj(this.idCita, this.idAdj);

  final int idCita;
  final int idAdj;
}
