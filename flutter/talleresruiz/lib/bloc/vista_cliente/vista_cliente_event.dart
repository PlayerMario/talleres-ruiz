part of './vista_cliente_bloc.dart';

abstract class VistaClienteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VistaClienteFetched extends VistaClienteEvent {}
