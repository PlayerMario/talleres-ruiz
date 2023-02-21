import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../main.dart';

abstract class AdMecServiceAbs {
  Future<dynamic> adMecLogout();
  Future<dynamic> getAdMecLogin();
  Future<dynamic> getListaMecanicos([int page = 0]);
}

@Order(2)
@singleton
class AdMecService extends AdMecServiceAbs {
  late LocalStorageService _localStorageService;
  late AdMecRepository _adMecRepository;

  AdMecService() {
    _adMecRepository = getIt<AdMecRepository>();
    GetIt.I
        .getAsync<LocalStorageService>()
        .then((value) => _localStorageService = value);
  }

  @override
  Future<dynamic> adMecLogout() async {
    print("Borrando token...");
    await _localStorageService.deleteFromDisk("user_token");
  }

  @override
  Future<dynamic> getAdMecLogin() async {
    print("Obteniendo datos del mecánico...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _adMecRepository.getAdMecMe();
      if (response.statusCode == 200) {
        return [MecanicoMeResponse.fromJson(jsonDecode(response.body)), true];
      } else {
        return [ErrorResponse.fromJson(jsonDecode(response.body)), false];
      }
    } else {
      return FormularioLogin();
    }
  }

  @override
  Future<dynamic> getListaMecanicos([int page = 0]) async {
    print("Obteniendo lista de mecánicos página $page...");
    String? token = _localStorageService.getFromDisk("user_token");
    if (token != null) {
      dynamic response = await _adMecRepository.getListaMecanicos(page);
      if (response.statusCode == 200) {
        return [
          MecanicoListadoResponse.fromJson(jsonDecode(response.body)),
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
