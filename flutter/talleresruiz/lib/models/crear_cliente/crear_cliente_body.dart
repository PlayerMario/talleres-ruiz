class CrearClienteBody {
  String? username;
  String? password;
  String? verifyPassword;
  String? dni;
  String? nombre;
  String? email;
  String? tlf;
  String? vehiculo;
  String? matricula;

  CrearClienteBody({
    required this.username,
    required this.password,
    required this.verifyPassword,
    required this.dni,
    required this.nombre,
    required this.email,
    required this.tlf,
    required this.vehiculo,
    required this.matricula,
  });

  CrearClienteBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
    dni = json['dni'];
    nombre = json['nombre'];
    email = json['email'];
    tlf = json['tlf'];
    vehiculo = json['vehiculo'];
    matricula = json['matricula'];
  }
}
