class LoginResponse {
  String? id;
  String? nombre;
  String? username;
  String? avatar;
  String? token;

  LoginResponse({
    required this.id,
    required this.nombre,
    required this.username,
    required this.avatar,
    required this.token,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    avatar = json['avatar'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['username'] = username;
    data['avatar'] = avatar;
    data['token'] = token;
    return data;
  }
}
