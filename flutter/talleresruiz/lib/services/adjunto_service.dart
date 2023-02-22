import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

abstract class AdjuntoServiceAbs {
  Future<dynamic> cambiarAvatar(File fichero, BuildContext context);
  Future<dynamic> agregarAdjunto(File fichero, int id, BuildContext context);
}

@Order(2)
@singleton
class AdjuntoService extends AdjuntoServiceAbs {
  late LocalStorageService _localStorageService;

  AdjuntoService() {
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> cambiarAvatar(File fichero, BuildContext context) async {
    print("Cambiando avatar...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/user/avatar'));
      request.headers.addAll({"Authorization": "Bearer $token"});
      request.files
          .add(await http.MultipartFile.fromPath("fichero", fichero.path));
      var response = await request.send();
      if (response.statusCode == 201) {
        showSnackbar("Avatar cambiado con éxito", context);
      } else {
        showSnackbar("No se ha podido completar la operación", context);
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> agregarAdjunto(
      File fichero, int id, BuildContext context) async {
    print("Guardando fichero en cita...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/auth/cita/$id/fichero'));
      request.headers.addAll({"Authorization": "Bearer $token"});
      request.files
          .add(await http.MultipartFile.fromPath("ficheros", fichero.path));
      var response = await request.send();
      if (response.statusCode == 200) {
        showSnackbar("Fichero agregado con éxito", context);
      } else {
        showSnackbar("No se ha podido completar la operación", context);
      }
    } else {
      return FormularioLogin();
    }
  }
}
