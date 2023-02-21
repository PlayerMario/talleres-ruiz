part of 'admec_bloc.dart';

abstract class AdMecEvent extends Equatable {
  const AdMecEvent();

  @override
  List<Object> get props => [];
}

class EventAdMecHome extends AdMecEvent {}

class EventDetallesMecanico extends AdMecEvent {
  const EventDetallesMecanico(this.id);

  final String id;
}

class EventLogoutAdMec extends AdMecEvent {}
