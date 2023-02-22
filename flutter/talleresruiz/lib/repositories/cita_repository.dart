import 'dart:ffi';

import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

@Order(-1)
@singleton
class CitaRepository {
  late RestAuthenticatedClient _http;

  CitaRepository() {
    _http = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> getListaCitas([int page = 0]) async {
    String url = "/auth/cita/?page=$page";
    var response = await _http.get(url);
    return response;
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

  Future<dynamic> postCrearCitaAdMec(CitaCrearAdMecBody citaCrearAdMec) async {
    final crearCita = {
      "dniCliente": citaCrearAdMec.dni,
      "fechaHora": citaCrearAdMec.fechaHora
    };
    String url = "/auth/cita/mecanico/me";
    var response = await _http.post(url, crearCita);
    return response;
  }

  Future<dynamic> putCitaCliente(
      int id, CitaCrearClienteBody editarCitaCliente) async {
    final editarCita = {"fechaHora": editarCitaCliente.fechaHora};
    String url = "/auth/cita/$id/cliente";
    var respone = await _http.put(url, editarCita);
    return respone;
  }

  Future<dynamic> putCitaAdMec(
      int id, CitaEditarAdMecBody editarCitaAdMec) async {
    final editarCita = {
      "fechaHora": editarCitaAdMec.fechaHora,
      "estado": editarCitaAdMec.estado
    };
    String url = "/auth/cita/mecanico/$id";
    var respone = await _http.put(url, editarCita);
    return respone;
  }

  Future<dynamic> delCitaCliente(int id) async {
    String url = "/auth/cita/$id/cliente";
    var response = await _http.delete(url);
    return response;
  }

  Future<dynamic> agregarMsj(AdjuntoMsjBody adjunto, int id) async {
    final msj = {"contenido": adjunto.contenido};
    String url = "/auth/cita/$id/mensaje";
    var response = await _http.post(url, msj);
    return response;
  }
}
