class MecanicoMeResponse {
  String? id;
  String? nombre;
  String? username;
  String? dni;
  String? email;
  String? tlf;
  String? avatar;
  List<String>? roles;

  MecanicoMeResponse(
      {this.id,
      this.nombre,
      this.username,
      this.dni,
      this.email,
      this.tlf,
      this.avatar,
      this.roles});

  MecanicoMeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    dni = json['dni'];
    email = json['email'];
    tlf = json['tlf'];
    avatar = json['avatar'];
    roles = json['roles'].cast<String>();
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
    data['roles'] = this.roles;
    return data;
  }
}
