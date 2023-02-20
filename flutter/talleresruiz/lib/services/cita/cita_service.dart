import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../main.dart';

abstract class CitaServiceAbs {
  Future<dynamic> getDetallesCita(int id);
  Future<dynamic> postCrearCitaCliente(CitaCrearClienteBody citaCrearCliente);
}

@Order(2)
@singleton
class CitaService extends CitaServiceAbs {
  late LocalStorageService _localStorageService;
  late CitaRepository _citaRepository;

  CitaService() {
    _citaRepository = getIt<CitaRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> getDetallesCita(int id) async {
    print("Obteniendo detalles de la cita...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _citaRepository.getDetallesCita(id);
      if (response.statusCode == 200) {
        return [CitaDetallesResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> postCrearCitaCliente(
      CitaCrearClienteBody citaCrearCliente) async {
    print("Creando nueva cita para cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response =
          await _citaRepository.postCrearCitaCliente(citaCrearCliente);
      if (response.statusCode == 201) {
        return [
          CitaDetallesResponse.fromJson(jsonDecode(response.body)),
          true
        ];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }
}
