import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/services/interceptor/interceptor.dart';
import '../../main.dart';

@Order(-1)
@singleton
class ClienteRepository {
  late RestAuthenticatedClient _http;

  ClienteRepository() {
    _http = getIt<RestAuthenticatedClient>();
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
}
