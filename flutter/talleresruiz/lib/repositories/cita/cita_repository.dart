import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../main.dart';

@Order(-1)
@singleton
class CitaRepository {
  late RestAuthenticatedClient _http;

  CitaRepository() {
    _http = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> getDetallesCita(int id) async {
    String url = "/auth/cita/$id";
    var respone = await _http.get(url);
    return respone;
  }

  Future<dynamic> postCrearCitaCliente(
      CitaCrearClienteBody crearCitaCliente) async {
    final crearCita = {"fechaHora": crearCitaCliente.fechaHora};
    String url = "/auth/cita/cliente";
    var response = await _http.post(url, crearCita);
    return response;
  }
}