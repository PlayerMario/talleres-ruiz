import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';

@singleton
class ClienteRepository {
  Future<List<dynamic>> getClienteMe() async {
    final response = await http.get(Uri.parse('$url/auth/cliente/me'));

    if (response.statusCode == 200) {
      return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }
  }
}
