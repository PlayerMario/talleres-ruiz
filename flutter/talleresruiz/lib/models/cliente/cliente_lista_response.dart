class ClienteListaResponse {
  String? id;
  String? nombre;
  String? username;
  String? dni;
  String? email;
  String? tlf;
  String? avatar;
  String? vehiculo;

  ClienteListaResponse(
      {this.id,
      this.nombre,
      this.username,
      this.dni,
      this.email,
      this.tlf,
      this.avatar,
      this.vehiculo});

  ClienteListaResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    dni = json['dni'];
    email = json['email'];
    tlf = json['tlf'];
    avatar = json['avatar'];
    vehiculo = json['vehiculo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['username'] = this.username;
    data['dni'] = this.dni;
    data['email'] = this.email;
    data['tlf'] = this.tlf;
    data['avatar'] = this.avatar;
    data['vehiculo'] = this.vehiculo;
    return data;
  }
}
