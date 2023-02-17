import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';
import 'package:talleresruiz/services/localstorage/localstorage_service.dart';

abstract class AuthenticationService {
  Future<dynamic> getCurrentUserCliente();
  //Future<dynamic> getCurrentUserMecanico();
  Future<dynamic> signIn(LoginBody login);
  Future<void> signOut();
}

@Order(2)
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
      //List<dynamic> response = await _clienteRepository.getClienteMe();
      /*if (response[1]) {
        return ClienteMeResponse.fromJson(jsonDecode(response[0].body));
      } else {
        return ErrorResponse.fromJson(jsonDecode(response[0].body));
      }*/
      dynamic response = await _clienteRepository.getClienteMe();
      if (response.statusCode == 200) {
      return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
    }
  }

  /*@override
  Future<dynamic> getCurrentUserMecanico() async {
    print("Obteniendo datos del mecánico...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      List<dynamic> response = await _mecanicoRepository.getMecanicoMe();
      if (response[1]) {
        return MecnaicoMeResponse.fromJson(jsonDecode(response[0].body));
      } else {
        return ErrorResponse.fromJson(jsonDecode(response[0].body));
      }
    }
  }*/

  @override
  Future<dynamic> signIn(LoginBody login) async {
    dynamic response = await _loginRepository.loginUser(login);
    /*if (response[1]) {
      await _localStorageService.saveToDisk('user_token', response[0].token);
      return response[0];
    } else {
      return response[0];
    }*/
    if (response.statusCode == 201) {
      LoginResponse resp = LoginResponse.fromJson(jsonDecode(response.body));
      await _localStorageService.saveToDisk('user_token', resp.token);
      return [resp, true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
  }

  @override
  Future<void> signOut() async {
    print("Borrando token...");
    await _localStorageService.deleteFromDisk("user_token");
  }
}
