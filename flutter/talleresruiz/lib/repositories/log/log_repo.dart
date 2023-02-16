import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';

//final headers = {"Content-Type": "application/json;charset=UTF-8"};
//final url = Uri.parse('http://localhost:8080/noauth/user/register');
//final url = Uri.parse('http://10.0.2.2:8080/noauth/user/register');
//late LocalStorageService _localStorageService;

Future<List<dynamic>> loginUser(LoginBody login) async {
  final userLogin = {"username": login.username, "password": login.password};

  final response =
      await http.post(Uri.parse('$url/noauth/user/login'), headers: headers, body: jsonEncode(userLogin));

  if (response.statusCode == 201) {
    LoginResponse resp = LoginResponse.fromJson(jsonDecode(response.body));
    await localStorageService.saveToDisk('user', jsonEncode(resp.toJson()));
    // El logout sería el deleteFromDisk
    return [resp, true];
  } else {
    return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
  }
}
