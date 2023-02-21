import 'dart:convert';

import '../../main.dart';

class ClienteMeResponse {
  String? id;
  String? nombre;
  String? username;
  String? dni;
  String? email;
  String? tlf;
  String? avatar;
  List<String>? roles;
  String? vehiculo;
  List<Citas>? citas;

  ClienteMeResponse(
      {this.id,
      this.nombre,
      this.username,
      this.dni,
      this.email,
      this.tlf,
      this.avatar,
      this.roles,
      this.vehiculo,
      this.citas});

  ClienteMeResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    dni = json['dni'];
    email = json['email'];
    tlf = json['tlf'];
    avatar = json['avatar'];
    roles = json['roles'].cast<String>();
    vehiculo = json['vehiculo'];
    if (json['citas'] != null) {
      citas = <Citas>[];
      json['citas'].forEach((v) {
        citas!.add(new Citas.fromJson(v));
      });
    }
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
    data['vehiculo'] = this.vehiculo;
    if (this.citas != null) {
      data['citas'] = this.citas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/*class Citas {
  String? mecanico;
  String? fechaHora;
  String? estado;

  Citas({this.mecanico, this.fechaHora, this.estado});

  Citas.fromJson(Map<String, dynamic> json) {
    mecanico = json['mecanico'];
    fechaHora = json['fechaHora'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mecanico'] = this.mecanico;
    data['fechaHora'] = this.fechaHora;
    data['estado'] = this.estado;
    return data;
  }
}*/
