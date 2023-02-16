part of './crear_cliente_bloc.dart';

abstract class CrearClienteEvent extends Equatable {
  const CrearClienteEvent();

  @override
  List<Object> get props => [];
}

class CrearClienteFetched extends CrearClienteEvent {
  const CrearClienteFetched(this.cliente);
  final CrearClienteBody cliente;
}
