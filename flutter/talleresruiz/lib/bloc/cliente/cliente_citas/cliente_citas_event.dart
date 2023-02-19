part of 'cliente_citas_bloc.dart';

abstract class ClienteCitasEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ClienteCitasFetched extends ClienteCitasEvent {}
