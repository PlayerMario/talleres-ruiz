class CitaDetallesResponse {
  int? id;
  String? mecanico;
  String? cliente;
  String? vehiculo;
  String? fechaHora;
  String? estado;
  List<Chat>? chat;

  CitaDetallesResponse(
      {this.id,
      this.mecanico,
      this.cliente,
      this.vehiculo,
      this.fechaHora,
      this.estado,
      this.chat});

  CitaDetallesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mecanico = json['mecanico'];
    cliente = json['cliente'];
    vehiculo = json['vehiculo'];
    fechaHora = json['fechaHora'];
    estado = json['estado'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mecanico'] = this.mecanico;
    data['cliente'] = this.cliente;
    data['vehiculo'] = this.vehiculo;
    data['fechaHora'] = this.fechaHora;
    data['estado'] = this.estado;
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chat {
  int? id;
  String? autor;
  String? fechaHora;
  String? contenido;
  bool? fichero;

  Chat({this.id, this.autor, this.fechaHora, this.contenido, this.fichero});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    autor = json['autor'];
    fechaHora = json['fechaHora'];
    contenido = json['contenido'];
    fichero = json['fichero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['autor'] = this.autor;
    data['fechaHora'] = this.fechaHora;
    data['contenido'] = this.contenido;
    data['fichero'] = this.fichero;
    return data;
  }
}