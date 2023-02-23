import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

@Order(-1)
@singleton
class UserRepository {
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
