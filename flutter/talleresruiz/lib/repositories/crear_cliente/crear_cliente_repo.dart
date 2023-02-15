import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import '../../main.dart';

final headers = {"Content-Type": "application/json;charset=UTF-8"};
final url = Uri.parse('http://localhost:8080/noauth/user/register');

@singleton
class CrearClienteRepo {
  late ResponseExceptions exceptions;

  Future<CrearCliente> crearCliente(
      String username,
      String password,
      String verifyPassword,
      String dni,
      String nombre,
      String email,
      String tlf,
      String vehiculo,
      String matricula) async {
    final crearCliente = {
      "username": username,
      "password": password,
      "verifyPassword": verifyPassword,
      "dni": dni,
      "nombre": nombre,
      "email": email,
      "tlf": tlf,
      "vehiculo": vehiculo,
      "matricula": matricula
    };

    final response =
        await http.post(url, headers: headers, body: jsonEncode(crearCliente));
    if (response.statusCode == 201) {
      return CrearCliente.fromJson(jsonDecode(response.body));
    } else {
      return exceptions.response(response);
    }
  }
}
