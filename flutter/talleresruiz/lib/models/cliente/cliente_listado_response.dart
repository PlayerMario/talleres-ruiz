import 'cliente_lista_response.dart';

class ClienteListadoResponse {
  List<ClienteListaResponse>? content;
  int? totalElements;
  int? totalPages;
  int? number;
  int? size;

  ClienteListadoResponse(
      {this.content,
      this.totalElements,
      this.totalPages,
      this.number,
      this.size});

  ClienteListadoResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <ClienteListaResponse>[];
      json['content'].forEach((v) {
        content!.add(new ClienteListaResponse.fromJson(v));
      });
    }
    totalElements = json['totalElements'];
    totalPages = json['totalPages'];
    number = json['number'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    data['totalElements'] = this.totalElements;
    data['totalPages'] = this.totalPages;
    data['number'] = this.number;
    data['size'] = this.size;
    return data;
  }
}

class Content {
  String? nombre;
  String? username;
  String? dni;
  String? email;
  String? tlf;
  String? avatar;
  String? vehiculo;

  Content(
      {this.nombre,
      this.username,
      this.dni,
      this.email,
      this.tlf,
      this.avatar,
      this.vehiculo});

  Content.fromJson(Map<String, dynamic> json) {
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
