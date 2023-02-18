class ClienteCrearResponse {
  String? nombre;
  String? username;
  String? dni;
  String? email;
  String? tlf;
  String? avatar;
  String? vehiculo;

  ClienteCrearResponse({
    required this.nombre,
    required this.username,
    required this.dni,
    required this.email,
    required this.tlf,
    required this.avatar,
    required this.vehiculo,
  });

  ClienteCrearResponse.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    username = json['username'];
    dni = json['dni'];
    email = json['email'];
    tlf = json['tlf'];
    avatar = json['avatar'];
    vehiculo = json['vehiculo'];
  }
}
