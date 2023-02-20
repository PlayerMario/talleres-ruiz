part of 'cliente_home_bloc.dart';

abstract class ClienteHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClienteHomeFetched extends ClienteHomeEvent {}

class ClienteEditarFetched extends ClienteHomeEvent {
  ClienteEditarFetched(this.cliente);
  
  final ClienteEditarBody cliente;

  /*@override
  List<Object> get props => [cliente];*/
}

class ClienteLogoutFetched extends ClienteHomeEvent {}