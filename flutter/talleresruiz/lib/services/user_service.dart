import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

abstract class UserServiceAbs {
  Future<dynamic> login(UserLoginBody login);
  Future<void> logout();
  Future<dynamic> putPswd(UserEditarPswdBody pswd);
}

@Order(2)
@singleton
class UserService extends UserServiceAbs {
  late UserRepository _userRepository;
  late LocalStorageService _localStorageService;

  UserService() {
    _userRepository = getIt<UserRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> login(UserLoginBody login) async {
    dynamic response = await _userRepository.loginUser(login);
    if (response.statusCode == 201) {
      UserLoginResponse resp =
          UserLoginResponse.fromJson(jsonDecode(response.body));
      await _localStorageService.saveToDisk("user_token", resp.token);
      print("Token guardado, logueando...");
      return [resp, true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
  }

  @override
  Future<void> logout() async {
    print("Borrando token...");
    await _localStorageService.deleteFromDisk("user_token");
  }

  @override
  Future<dynamic> putPswd(UserEditarPswdBody pswd) async {
    print("Modificando contraseña...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _userRepository.putPswd(pswd);
      if (response.statusCode == 200) {
        return [UserEditarPswdResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }
}
