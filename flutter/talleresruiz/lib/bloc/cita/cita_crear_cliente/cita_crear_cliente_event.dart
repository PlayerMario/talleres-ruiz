part of 'cita_crear_cliente_bloc.dart';

abstract class CitaCrearClienteEvent extends Equatable {
  const CitaCrearClienteEvent();

  @override
  List<Object> get props => [];
}

class CitaCrearClienteFetched extends CitaCrearClienteEvent {
  const CitaCrearClienteFetched(this.cita);

  final CitaCrearClienteBody cita;
}
