part of 'cliente_borrar_bloc.dart';

abstract class ClienteBorrarEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClienteBorrarFetched extends ClienteBorrarEvent {}
