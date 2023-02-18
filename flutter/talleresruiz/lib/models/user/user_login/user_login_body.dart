class UserLoginBody {
  String? username;
  String? password;

  UserLoginBody({required this.username, required this.password});

  UserLoginBody.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }
}
