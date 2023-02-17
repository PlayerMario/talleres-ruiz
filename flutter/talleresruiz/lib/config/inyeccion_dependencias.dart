import 'package:get_it/get_it.dart'; 
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talleresruiz/services/localstorage/localstorage_service.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.config.dart';


final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

void setupAsyncDependencies() {
  getIt.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());
  getIt.registerSingletonAsync<LocalStorageService>(() => LocalStorageService.getInstance());
}

// TERMINAL : flutter packages pub run build_runner build para quitar error de init()