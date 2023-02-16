import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';

final headers = {"Content-Type": "application/json;charset=UTF-8"};
final url = Uri.parse('http://localhost:8080/noauth/user/register');

Future<List<dynamic>> crearCliente(CrearClienteBody cliente) async {
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

  final response =
      await http.post(url, headers: headers, body: jsonEncode(crearCliente));
  if (response.statusCode == 201) {
    return [CrearClienteResponse.fromJson(jsonDecode(response.body)), true];
  } else {
    return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
  }
}
