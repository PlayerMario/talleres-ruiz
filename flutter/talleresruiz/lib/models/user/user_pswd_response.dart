class UserEditarPswdResponse {
  String? id;
  String? username;
  String? nombre;
  String? avatar;

  UserEditarPswdResponse({this.id, this.username, this.nombre, this.avatar});

  UserEditarPswdResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nombre = json['nombre'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nombre'] = this.nombre;
    data['avatar'] = this.avatar;
    return data;
  }
}