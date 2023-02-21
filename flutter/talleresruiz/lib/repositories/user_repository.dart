import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/services/interceptor.dart';
import '../main.dart';
import '../services/localstorage_service.dart';

@Order(-1)
@singleton
class UserRepository {
  //late LocalStorageService _localStorageService;
  late Interceptor _http;
  late RestAuthenticatedClient _httpAuth;

  UserRepository() {
    _http = GetIt.I.get<Interceptor>();
    _httpAuth = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> loginUser(UserLoginBody login) async {
    final userLogin = {"username": login.username, "password": login.password};
    String url = "/noauth/user/login";
    var response = await _http.post(url, userLogin);
    return response;
  }

  Future<dynamic> putPswd(UserEditarPswdBody pswd) async {
    final userPswd = {
      "oldPassword": pswd.oldPassword,
      "newPassword": pswd.newPassword,
      "verifyNewPassword": pswd.verifyNewPassword
    };
    String url = "/auth/user/changePsw";
    var response = await _httpAuth.put(url, userPswd);
    return response;
  }
}
