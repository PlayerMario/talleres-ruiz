import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

abstract class ClienteServiceAbs {
  Future<dynamic> clienteLogout();
  Future<dynamic> getClienteLogin();
  Future<dynamic> getDetallesCliente(String id);
  Future<dynamic> getClienteCitas([int page = 0]);
  Future<dynamic> getListaClientes([int page = 0]);
  Future<dynamic> putCliente(ClienteEditarBody cliente);
  Future<dynamic> delCliente();
  Future<dynamic> delClienteAdMec(String id);
}

@Order(2)
@singleton
class ClienteService extends ClienteServiceAbs {
  late LocalStorageService _localStorageService;
  late ClienteRepository _clienteRepository;

  ClienteService() {
    _clienteRepository = getIt<ClienteRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> clienteLogout() async {
    print("Borrando token...");
    await _localStorageService.deleteFromDisk("user_token");
  }

  @override
  Future<dynamic> getClienteLogin() async {
    print("Obteniendo datos del cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.getClienteMe();
      if (response.statusCode == 200) {
        return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> getDetallesCliente(String id) async {
    print("Obteniendo detalles del cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.getDetallesCliente(id);
      if (response.statusCode == 200) {
        return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> getClienteCitas([int page = 0]) async {
    print("Obteniendo citas del cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.getClienteCitas(page);
      if (response.statusCode == 200) {
        return [ClienteCitasResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> getListaClientes([int page = 0]) async {
    print("Obteniendo lista de clientes página $page...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.getListaClientes(page);
      if (response.statusCode == 200) {
        return [
          ClienteListadoResponse.fromJson(jsonDecode(response.body)),
          true
        ];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> putCliente(ClienteEditarBody cliente) async {
    print("Modificando cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.putCliente(cliente);
      if (response.statusCode == 200) {
        return [ClienteMeResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> delCliente() async {
    print("Borrando cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.delCliente();
      if (response.statusCode == 204) {
        _localStorageService.deleteFromDisk("user_token");
        return [null, true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> delClienteAdMec(String id) async {
    print("Borrando cliente...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _clienteRepository.delClienteAdMec(id);
      if (response.statusCode == 204) {
        _localStorageService.deleteFromDisk("user_token");
        return [null, true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }
}
