import 'package:injectable/injectable.dart';
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

  Future<dynamic> getDetallesMecanico(String id) async {
    String url = "/auth/mecanico/$id";
    var response = await _http.get(url);
    return response;
  }

  Future<dynamic> getListaMecanicos([int page = 0]) async {
    String url = "/auth/mecanico/?page=$page";
    var response = await _http.get(url);
    return response;
  }

  Future<dynamic> crearAdMec(AdMecCrearBody adMec, int opcion) async {
    final crearAdMec = {
      "username": adMec.username,
      "password": adMec.password,
      "verifyPassword": adMec.verifyPassword,
      "dni": adMec.dni,
      "nombre": adMec.nombre,
      "email": adMec.email,
      "tlf": adMec.tlf,
    };
    String url = "";
    if (opcion == 1) {
      url = "/auth/mecanico/admin";
    } else {
      url = "/auth/mecanico/mec";
    }
    var response = await _http.post(url, crearAdMec);
    return response;
  }

  Future<dynamic> editarAdMec(AdMecEditarBody adMec, String id) async {
    final editAdMec = {
      "nombre": adMec.nombre,
      "email": adMec.email,
      "tlf": adMec.tlf,
    };
    String url = "/auth/mecanico/$id";
    var response = await _http.put(url, editAdMec);
    return response;
  }
}
