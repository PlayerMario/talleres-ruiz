import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../main.dart';

abstract class ClienteServiceAbs {
  Future<dynamic> getClienteLogin();
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
    }
  }
}
