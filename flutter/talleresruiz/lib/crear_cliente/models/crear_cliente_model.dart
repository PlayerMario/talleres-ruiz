class CrearCliente {
  String? id;
  String? nombre;
  String? username;
  String? dni;
  //DateTime? fechaNacimiento;
  String? fechaNacimiento;
  String? email;
  String? tlf;
  List<String>? roles;
  String? vehiculo;

  CrearCliente({
    required this.id,
    required this.nombre,
    required this.username,
    required this.dni,
    required this.fechaNacimiento,
    required this.email,
    required this.tlf,
    required this.roles,
    required this.vehiculo,
  });

  CrearCliente.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    dni = json['dni'];
    fechaNacimiento = json['fechaNacimiento'];
    email = json['email'];
    tlf = json['tlf'];
    if(json['roles'] != null) {
      roles = <String>[];
      json['roles'].forEach((v) {
        roles!.add(v);
      });
    }
    roles = json['roles'];
    vehiculo = json['vehiculo'];
  }

}