// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:talleresruiz/repositories/admec_repository.dart' as _i4;
import 'package:talleresruiz/repositories/cita_repository.dart' as _i5;
import 'package:talleresruiz/repositories/cliente_repository.dart' as _i6;
import 'package:talleresruiz/repositories/user_repository.dart' as _i7;
import 'package:talleresruiz/services/adjunto_service.dart' as _i9;
import 'package:talleresruiz/services/admec_service.dart' as _i8;
import 'package:talleresruiz/services/cita_service.dart' as _i10;
import 'package:talleresruiz/services/cliente_service.dart' as _i11;
import 'package:talleresruiz/services/interceptor.dart' as _i3;
import 'package:talleresruiz/services/user_service.dart' as _i12;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.Interceptor>(_i3.Interceptor());
    gh.singleton<_i3.RestAuthenticatedClient>(_i3.RestAuthenticatedClient());
    gh.singleton<_i4.AdMecRepository>(_i4.AdMecRepository());
    gh.singleton<_i5.CitaRepository>(_i5.CitaRepository());
    gh.singleton<_i6.ClienteRepository>(_i6.ClienteRepository());
    gh.singleton<_i7.UserRepository>(_i7.UserRepository());
    gh.singleton<_i8.AdMecService>(_i8.AdMecService());
    gh.singleton<_i9.AdjuntoService>(_i9.AdjuntoService());
    gh.singleton<_i10.CitaService>(_i10.CitaService());
    gh.singleton<_i11.ClienteService>(_i11.ClienteService());
    gh.singleton<_i12.UserService>(_i12.UserService());
    return this;
  }
}
