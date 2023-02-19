part of 'cita_detalles_bloc.dart';

enum CitaDetallesStatus { initial, success, failure }

class CitaDetallesState extends Equatable {
  const CitaDetallesState(
      {this.status = CitaDetallesStatus.initial, this.citaDetalles});

  final CitaDetallesStatus status;
  final dynamic citaDetalles;

  CitaDetallesState copyWith({CitaDetallesStatus? status, dynamic citaDetalles}) {
    return CitaDetallesState(
        status: status ?? this.status, citaDetalles: citaDetalles ?? this.citaDetalles);
  }

  @override
  List<Object> get props => [];
}