part of './crear_cliente_bloc.dart';

enum CrearClienteStatus { initial, success, failure }

class CrearClienteState extends Equatable {
  const CrearClienteState(
      {this.status = CrearClienteStatus.initial, this.clienteCreado});

  final CrearClienteStatus status;
  final CrearCliente? clienteCreado;

  CrearClienteState copyWith(
      {CrearClienteStatus? status, CrearCliente? clienteCreado}) {
    return CrearClienteState(
        status: status ?? this.status,
        clienteCreado: clienteCreado ?? this.clienteCreado);
  }

  @override
  List<Object> get props => [];
}
