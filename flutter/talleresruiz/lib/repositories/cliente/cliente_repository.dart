import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';

@Order(-1)
@singleton
class ClienteRepository {
  Future<dynamic> getClienteMe() async {
    final response = await http.get(Uri.parse('$url/auth/cliente/me'));
    return response;
    /*if (response.statusCode == 200) {
      return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }*/
  }
}
