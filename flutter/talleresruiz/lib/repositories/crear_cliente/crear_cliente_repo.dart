import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/services/interceptor/interceptor.dart';
import '../../main.dart';

@Order(-1)
@singleton
class CrearClienteRepository {
  late Interceptor _http;

  CrearClienteRepository() {
    _http = GetIt.I.get<Interceptor>();
  }

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

    String url = '/noauth/user/register';

    /*final response = await http.post(Uri.parse('$url/noauth/user/register'),
        headers: headers, body: jsonEncode(crearCliente));*/
    
    final response = await _http.post(url, cliente);

    if (response.statusCode == 201) {
      return [CrearClienteResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
  }
}
