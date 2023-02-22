class AdjuntoMsjBody {
  String? contenido;

  AdjuntoMsjBody({this.contenido});

  AdjuntoMsjBody.fromJson(Map<String, dynamic> json) {
    contenido = json['contenido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contenido'] = this.contenido;
    return data;
  }
}

//CitaDetallesResponse