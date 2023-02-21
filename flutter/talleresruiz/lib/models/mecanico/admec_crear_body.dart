class AdMecCrearBody {
  String? username;
  String? password;
  String? verifyPassword;
  String? dni;
  String? nombre;
  String? email;
  String? tlf;

  AdMecCrearBody({
    required this.username,
    required this.password,
    required this.verifyPassword,
    required this.dni,
    required this.nombre,
    required this.email,
    required this.tlf,
  });

  AdMecCrearBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    verifyPassword = json['verifyPassword'];
    dni = json['dni'];
    nombre = json['nombre'];
    email = json['email'];
    tlf = json['tlf'];
  }
}

class AdMecEditarBody {
  String? nombre;
  String? email;
  String? tlf;

  AdMecEditarBody({
    required this.nombre,
    required this.email,
    required this.tlf,
  });

  AdMecEditarBody.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    email = json['email'];
    tlf = json['tlf'];
  }
}
