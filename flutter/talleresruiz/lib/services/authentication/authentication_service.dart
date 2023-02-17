import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';
import 'package:talleresruiz/services/localstorage/localstorage_service.dart';

abstract class AuthenticationService {
  Future<dynamic> getCurrentUserCliente();
  Future<dynamic> signIn(LoginBody login);
  Future<void> signOut();
}

@singleton
class JwtAuthenticationService extends AuthenticationService {
  late LoginRepository _loginRepository;
  late LocalStorageService _localStorageService;
  late ClienteRepository _clienteRepository;
  //late MecanicoRepository _mecanicoRepository;

  JwtAuthenticationService() {
    _loginRepository = getIt<LoginRepository>();
    _clienteRepository = getIt<ClienteRepository>();
    //_mecanicoRepository = getIt<MecanicoRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> getCurrentUserCliente() async {
    print("Obteniendo datos del cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      LoginResponse response = await _clienteRepository.getClienteMe();
      return response;
    }
    return null;
  }

  @override
  Future<dynamic> signIn(LoginBody login) async {
    List<dynamic> response = await _loginRepository.loginUser(login);
    if (response[1]) {
      await _localStorageService.saveToDisk('user_token', response[0].token);
      return LoginResponse.fromJson(jsonDecode(response[0].body));
    } else {
      return ErrorResponse.fromJson(jsonDecode(response[0].body));
    }
  }

  @override
  Future<void> signOut() async {
    print("Borrando token...");
    await _localStorageService.deleteFromDisk("user_token");
  }
}
