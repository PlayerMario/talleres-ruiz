import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../main.dart';
import '../../services/localstorage/localstorage_service.dart';

@Order(-1)
@singleton
class LoginRepository {
  //late LocalStorageService _localStorageService;

  /*Future<List<dynamic>>*/Future<dynamic> loginUser(LoginBody login) async {
    //GetIt.I.getAsync<LocalStorageService>().then((value) => _localStorageService = value);
    
    final userLogin = {"username": login.username, "password": login.password};

    final response = await http.post(Uri.parse('$url/noauth/user/login'),
        headers: headers, body: jsonEncode(userLogin));

    return response;
    /*if (response.statusCode == 201) {
      LoginResponse resp = LoginResponse.fromJson(jsonDecode(response.body));
      //await _localStorageService.saveToDisk('user_token', resp.token);
      return [resp, true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }*/
  }
}
