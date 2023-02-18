import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/services/interceptor/interceptor.dart';
import '../../main.dart';
import '../../services/localstorage/localstorage_service.dart';

@Order(-1)
@singleton
class UserRepository {
  //late LocalStorageService _localStorageService;
  late Interceptor _http;

  UserRepository() {
    _http = GetIt.I.get<Interceptor>();
  }

  /*Future<List<dynamic>>*/Future<dynamic> loginUser(UserLoginBody login) async {
    //GetIt.I.getAsync<LocalStorageService>().then((value) => _localStorageService = value);

    final userLogin = {"username": login.username, "password": login.password};
    String url = "/noauth/user/login";

    /*final response = await http.post(Uri.parse('$url/noauth/user/login'),
        headers: headers, body: jsonEncode(userLogin));*/
    
    var response = await _http.post(url, userLogin);

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
