import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../main.dart';

@Order(-1)
@singleton
class ClienteRepository {
  late RestAuthenticatedClient _http;

  ClienteRepository() {
    _http = getIt<RestAuthenticatedClient>();
  }

  Future<List<dynamic>> crearCliente(ClienteCrearBody cliente) async {
    final crearCliente = {
      "username": cliente.username,
      "password": cliente.password,
      "verifyPassword": cliente.verifyPassword,
      "dni": cliente.dni,
      "nombre": cliente.nombre,
      "email": cliente.email,
      "tlf": cliente.tlf,
      "vehiculo": cliente.vehiculo,
      "matricula": cliente.matricula
    };

    //String url = '/noauth/user/register';
    //const url = 'http://localhost:8080';
    //const url = 'http://10.0.2.2:8080';
    //const headers = {"Content-Type": "application/json;charset=UTF-8"};

    final response = await http.post(Uri.parse('$baseUrl/noauth/user/register'),
        headers: headers, body: jsonEncode(crearCliente));

    //final response = await _http.post(url, cliente);

    if (response.statusCode == 201) {
      return [ClienteCrearResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
  }

  Future<dynamic> getClienteMe() async {
    String url = "/auth/cliente/me";
    var response = await _http.get(url);
    //final response = await http.get(Uri.parse('$url/auth/cliente/me'));
    return response;
    /*if (response.statusCode == 200) {
      return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }*/
  }

  Future<dynamic> getClienteCitas([int page = 0]) async {
    String url = "/auth/cliente/me/citas?page=$page";
    var response = await _http.get(url);
    return response;
  }

  Future<dynamic> putCliente(ClienteEditarBody cliente) async {
    final editarCliente = {
      "nombre": cliente.nombre,
      "email": cliente.email,
      "tlf": cliente.tlf,
      "vehiculo": cliente.vehiculo,
      "matricula": cliente.matricula
    };
    String url = "/auth/cliente/me";
    var response = await _http.put(url, editarCliente);
    return response;
  }

  Future<dynamic> delCliente() async {
    String url = "/auth/cliente/me";
    var response = await _http.delete(url);
    return response;
  }
}
