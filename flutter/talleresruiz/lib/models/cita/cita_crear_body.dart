class CitaCrearClienteBody {
  String? fechaHora;

  CitaCrearClienteBody({this.fechaHora});

  CitaCrearClienteBody.fromJson(Map<String, dynamic> json) {
    fechaHora = json['fechaHora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fechaHora'] = this.fechaHora!;
    return data;
  }
}

class CitaCrearAdMecBody {
  String? dni;
  String? fechaHora;

  CitaCrearAdMecBody({this.dni, this.fechaHora});

  CitaCrearAdMecBody.fromJson(Map<String, dynamic> json) {
    dni = json['dni'];
    fechaHora = json['fechaHora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dni'] = this.dni!;
    data['fechaHora'] = this.fechaHora!;
    return data;
  }
}


class CitaEditarAdMecBody {
  String? fechaHora;
  String? estado;

  CitaEditarAdMecBody({this.fechaHora, this.estado});

  CitaEditarAdMecBody.fromJson(Map<String, dynamic> json) {
    fechaHora = json['fechaHora'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fechaHora'] = this.fechaHora;
    data['estado'] = this.estado;
    return data;
  }
}