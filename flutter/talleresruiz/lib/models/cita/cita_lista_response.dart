class CitaListaResponse {
  int? id;
  String? mecanico;
  String? cliente;
  String? vehiculo;
  String? fechaHora;
  String? estado;

  CitaListaResponse(
      {this.id,
      this.mecanico,
      this.cliente,
      this.vehiculo,
      this.fechaHora,
      this.estado});

  CitaListaResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mecanico = json['mecanico'];
    cliente = json['cliente'];
    vehiculo = json['vehiculo'];
    fechaHora = json['fechaHora'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mecanico'] = this.mecanico;
    data['cliente'] = this.cliente;
    data['vehiculo'] = this.vehiculo;
    data['fechaHora'] = this.fechaHora;
    data['estado'] = this.estado;
    return data;
  }
}
