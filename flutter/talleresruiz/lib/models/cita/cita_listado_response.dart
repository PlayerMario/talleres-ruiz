import 'cita_lista_response.dart';

class CitaListadoResponse {
  List<CitaListaResponse>? content;
  int? totalElements;
  int? totalPages;
  int? number;
  int? size;

  CitaListadoResponse(
      {this.content,
      this.totalElements,
      this.totalPages,
      this.number,
      this.size});

  CitaListadoResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <CitaListaResponse>[];
      json['content'].forEach((v) {
        content!.add(new CitaListaResponse.fromJson(v));
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