part of './crear_cliente_bloc.dart';

abstract class CrearClienteEvent extends Equatable {
  const CrearClienteEvent();

  @override
  List<Object> get props => [];
}

class CrearClienteFetched extends CrearClienteEvent {
  const CrearClienteFetched(
      this.username,
      this.password,
      this.passwordVerify,
      this.dni,
      this.nombre,
      this.fechaNacimiento,
      this.email,
      this.tlf,
      this.vehiculo,
      this.matricula);
  final String username;
  final String password;
  final String passwordVerify;
  final String dni;
  final String nombre;
  //final DateTime fechaNacimiento;
  final String fechaNacimiento;
  final String email;
  final String tlf;
  final String vehiculo;
  final String matricula;
}
