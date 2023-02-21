class UserLoginResponse {
  String? id;
  String? nombre;
  String? username;
  String? avatar;
  List<String>? roles;
  String? token;

  UserLoginResponse({
    required this.id,
    required this.nombre,
    required this.username,
    required this.avatar,
    required this.roles,
    required this.token,
  });

  UserLoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    username = json['username'];
    avatar = json['avatar'];
    token = json['token'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nombre'] = nombre;
    data['username'] = username;
    data['avatar'] = avatar;
    data['roles'] = roles;
    data['token'] = token;
    return data;
  }
}
