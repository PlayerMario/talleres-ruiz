part of 'cliente_editar_bloc.dart';

abstract class ClienteEditarEvent extends Equatable {
  const ClienteEditarEvent();

  @override
  List<Object> get props => [];
}

class ClienteEditarFetch extends ClienteEditarEvent {
  const ClienteEditarFetch(this.cliente);
  
  final ClienteEditarBody cliente;
}
