class LoginBody {
  String? username;
  String? password;

  LoginBody({required this.username, required this.password});

  LoginBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
