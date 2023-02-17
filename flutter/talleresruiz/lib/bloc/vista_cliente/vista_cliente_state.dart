part of './vista_cliente_bloc.dart';

enum VistaClienteStatus { initial, success, failure }

class VistaClienteState extends Equatable {
  const VistaClienteState(
      {this.status = VistaClienteStatus.initial, this.clienteMe});

  final VistaClienteStatus status;
  final dynamic clienteMe;

  VistaClienteState copyWith({VistaClienteStatus? status, dynamic clienteMe}) {
    return VistaClienteState(
        status: status ?? this.status, clienteMe: clienteMe ?? this.clienteMe);
  }

  @override
  List<Object> get props => [];
}
