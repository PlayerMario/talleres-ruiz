import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

/*@InjectableInit()
void configureDependencies() => getIt.init();

void setupAsyncDependencies() {
  getIt.registerSingletonAsync<LocalStorageService>(() => LocalStorageService.getInstance());
}*/

// TERMINAL : flutter packages pub run build_runner build para quitar error de init()