import 'package:injectable/injectable.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

@Order(-1)
@singleton
class AdMecRepository {
  late RestAuthenticatedClient _http;

  AdMecRepository() {
    _http = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> getAdMecMe() async {
    String url = "/auth/mecanico/me";
    var response = await _http.get(url);
    return response;
  }

  Future<dynamic> getListaMecanicos([int page = 0]) async {
    String url = "/auth/mecanico/?page=$page";
    var response = await _http.get(url);
    return response;
  }
}
