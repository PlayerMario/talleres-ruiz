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
