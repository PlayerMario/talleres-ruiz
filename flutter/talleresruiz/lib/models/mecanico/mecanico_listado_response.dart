import 'mecanico_lista_response.dart';

class MecanicoListadoResponse {
  List<MecanicoListaResponse>? content;
  int? totalElements;
  int? totalPages;
  int? number;
  int? size;

  MecanicoListadoResponse(
      {this.content,
      this.totalElements,
      this.totalPages,
      this.number,
      this.size});

  MecanicoListadoResponse.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <MecanicoListaResponse>[];
      json['content'].forEach((v) {
        content!.add(new MecanicoListaResponse.fromJson(v));
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
