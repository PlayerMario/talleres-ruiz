import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../main.dart';

abstract class UserServiceAbs {
  //Future<dynamic> getClienteLogin();
  //Future<dynamic> getMecanicoLogin();
  Future<dynamic> login(UserLoginBody login);
  Future<void> logout();
}

@Order(2)
@singleton
class UserService extends UserServiceAbs {
  late UserRepository _userRepository;
  late LocalStorageService _localStorageService;
  //late ClienteRepository _clienteRepository;
  //late MecanicoRepository _mecanicoRepository;

  UserService() {
    _userRepository = getIt<UserRepository>();
    //_clienteRepository = getIt<ClienteRepository>();
    //_mecanicoRepository = getIt<MecanicoRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  /*@override
  Future<dynamic> getClienteLogin() async {
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
  }*/

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
  Future<dynamic> login(UserLoginBody login) async {
    dynamic response = await _userRepository.loginUser(login);
    if (response.statusCode == 201) {
      LoginResponse resp = LoginResponse.fromJson(jsonDecode(response.body));
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
}
