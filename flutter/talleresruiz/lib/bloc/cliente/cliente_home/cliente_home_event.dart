part of 'cliente_home_bloc.dart';

abstract class ClienteHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClienteHomeFetched extends ClienteHomeEvent {}
