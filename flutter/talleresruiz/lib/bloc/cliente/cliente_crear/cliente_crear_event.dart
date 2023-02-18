part of 'cliente_crear_bloc.dart';

abstract class ClienteCrearEvent extends Equatable {
  const ClienteCrearEvent();

  @override
  List<Object> get props => [];
}

class ClienteCrearFetched extends ClienteCrearEvent {
  const ClienteCrearFetched(this.cliente);
  
  final ClienteCrearBody cliente;
}
