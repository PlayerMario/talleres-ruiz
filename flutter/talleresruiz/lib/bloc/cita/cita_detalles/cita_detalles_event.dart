part of 'cita_detalles_bloc.dart';

abstract class CitaDetallesEvent extends Equatable {
  const CitaDetallesEvent();

  @override
  List<Object> get props => [];
}

class CitaDetallesFetched extends CitaDetallesEvent {
  const CitaDetallesFetched(this.id);

  final int id;
}

class CitaBorrarClienteFetched extends CitaDetallesEvent {
  const CitaBorrarClienteFetched(this.id);

  final int id;
}
