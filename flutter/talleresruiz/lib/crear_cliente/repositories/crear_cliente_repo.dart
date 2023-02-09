import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/crear_cliente/crear_cliente.dart';

final headers = {"Content-Type": "application/json;charset=UTF-8"};
final url = Uri.parse('http://localhost:8080/noauth/user/register');

Future<CrearCliente> buscarClienteCreado(
    String username,
    String password,
    String passwordVerify,
    String dni,
    String nombre,
    //DateTime fechaNacimiento,
    String fechaNacimiento,
    String email,
    String tlf,
    String vehiculo,
    String matricula) async {
  final crearCliente = {
    "username": username,
    "password": password,
    "passwordVerify": passwordVerify,
    "dni": dni,
    "nombre": nombre,
    "fechaNacimiento": fechaNacimiento,
    "email": email,
    "tlf": tlf,
    "vehiculo": vehiculo,
    "matricula": matricula
  };

  final response =
      await http.post(url, headers: headers, body: jsonEncode(crearCliente));

  // VER CÓMO RECIBIR SI VIENE MAL LA GESTIÓN DE ERRORES PARA MOSTRAR EL MENSAJE PERSONALIZADO
  if (response.statusCode == 201) {
    return CrearCliente.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error al crear el usuario");
  }
}
