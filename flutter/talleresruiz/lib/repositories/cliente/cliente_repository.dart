import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/services/interceptor/interceptor.dart';
import '../../main.dart';

@Order(-1)
@singleton
class ClienteRepository {
  late Interceptor _http;

  LoginRepository() {
    _http = GetIt.I.get<Interceptor>();
  }

  Future<dynamic> getClienteMe() async {
    String url = '';
    final response = await _http.get(url);
    //final response = await http.get(Uri.parse('$url/auth/cliente/me'));
    return response;
    /*if (response.statusCode == 200) {
      return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
    } else {
      return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
    }*/
  }
}
