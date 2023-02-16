part of './crear_cliente_bloc.dart';

enum CrearClienteStatus { initial, success, failure }

class CrearClienteState extends Equatable {
  const CrearClienteState(
      {this.status = CrearClienteStatus.initial, this.clienteCreado});

  final CrearClienteStatus status;
  //final CrearClienteResponse? clienteCreado;
  final dynamic clienteCreado;

  CrearClienteState copyWith(
      {CrearClienteStatus? status, /*CrearClienteResponse? clienteCreado*/ dynamic clienteCreado}) {
    return CrearClienteState(
        status: status ?? this.status,
        clienteCreado: clienteCreado ?? this.clienteCreado);
  }

  @override
  List<Object> get props => [];
}
