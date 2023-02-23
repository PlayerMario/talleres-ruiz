class ClienteCitasResponse {
  List<Citas>? content;
  int? totalElements;
  int? totalPages;
  int? number;
  int? size;

  ClienteCitasResponse(
      {this.content,
      this.totalElements,
      this.totalPages,
      this.number,
      this.size});

  ClienteCitasResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <Citas>[];
      json['content'].forEach((v) {
        content!.add(new Citas.fromJson(v));
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

class Citas {
  int? id;
  String? mecanico;
  String? fechaHora;
  String? estado;

  Citas({this.id, this.mecanico, this.fechaHora, this.estado});

  Citas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mecanico = json['mecanico'];
    fechaHora = json['fechaHora'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mecanico'] = this.mecanico;
    data['fechaHora'] = this.fechaHora;
    data['estado'] = this.estado;
    return data;
  }
}
