part of 'cita_crear_cliente_bloc.dart';

enum CitaCrearClienteStatus { initial, success, failure }

class CitaCrearClienteState extends Equatable {
  const CitaCrearClienteState(
      {this.status = CitaCrearClienteStatus.initial, this.citaClienteCreada});

  final CitaCrearClienteStatus status;
  final dynamic citaClienteCreada;

  CitaCrearClienteState copyWith(
      {CitaCrearClienteStatus? status, dynamic citaClienteCreada}) {
    return CitaCrearClienteState(
        status: status ?? this.status,
        citaClienteCreada: citaClienteCreada ?? this.citaClienteCreada);
  }

  @override
  List<Object> get props => [];
}
