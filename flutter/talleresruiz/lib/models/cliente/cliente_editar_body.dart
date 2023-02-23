class ClienteEditarBody {
  String? nombre;
  String? email;
  String? tlf;
  String? vehiculo;
  String? matricula;

  ClienteEditarBody(
      {this.nombre, this.email, this.tlf, this.vehiculo, this.matricula});

  ClienteEditarBody.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    email = json['email'];
    tlf = json['tlf'];
    vehiculo = json['vehiculo'];
    matricula = json['matricula'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nombre'] = this.nombre;
    data['email'] = this.email;
    data['tlf'] = this.tlf;
    data['vehiculo'] = this.vehiculo;
    data['matricula'] = this.matricula;
    return data;
  }
}
