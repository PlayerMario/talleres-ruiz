import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

abstract class CitaServiceAbs {
  Future<dynamic> getListaCitas([int page = 0]);
  Future<dynamic> getDetallesCita(int id);
  Future<dynamic> postCrearCitaCliente(CitaCrearClienteBody citaCrearCliente);
  Future<dynamic> postCrearCitaAdMec(CitaCrearAdMecBody citaCrearAdMec);
  Future<dynamic> putCitaCliente(int id, CitaCrearClienteBody citaEditar);
  Future<dynamic> putCitaAdMec(int id, CitaEditarAdMecBody citaEditar);
  Future<dynamic> delCitaCliente(int id);
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
  Future<dynamic> getListaCitas([int page = 0]) async {
    print("Obteniendo lista de citas página $page...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _citaRepository.getListaCitas(page);
      if (response.statusCode == 200) {
        return [CitaListadoResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
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
        return [CitaDetallesResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> postCrearCitaAdMec(CitaCrearAdMecBody citaCrearAdMec) async {
    print("Creando nueva cita para mecánico...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response =
          await _citaRepository.postCrearCitaAdMec(citaCrearAdMec);
      if (response.statusCode == 201) {
        return [CitaDetallesResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> putCitaCliente(
      int id, CitaCrearClienteBody citaEditar) async {
    print("Modificando cita para cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _citaRepository.putCitaCliente(id, citaEditar);
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
  Future<dynamic> putCitaAdMec(int id, CitaEditarAdMecBody citaEditar) async {
    print("Modificando cita para mecánico...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _citaRepository.putCitaAdMec(id, citaEditar);
      if (response.statusCode == 200) {
        return [CitaListaResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> delCitaCliente(int id) async {
    print("Borrando cita del cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _citaRepository.delCitaCliente(id);
      if (response.statusCode == 204) {
        return [null, true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }
}
