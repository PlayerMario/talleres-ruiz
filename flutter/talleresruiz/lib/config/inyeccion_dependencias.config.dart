// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:talleresruiz/repositories/cita/cita_repository.dart' as _i4;
import 'package:talleresruiz/repositories/cliente/cliente_repository.dart'
    as _i5;
import 'package:talleresruiz/repositories/user/user_repo.dart' as _i6;
import 'package:talleresruiz/services/cita/cita_service.dart' as _i7;
import 'package:talleresruiz/services/cliente/cliente_service.dart' as _i8;
import 'package:talleresruiz/services/interceptor/interceptor.dart' as _i3;
import 'package:talleresruiz/services/user/user_service.dart' as _i9;

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
    gh.singleton<_i4.CitaRepository>(_i4.CitaRepository());
    gh.singleton<_i5.ClienteRepository>(_i5.ClienteRepository());
    gh.singleton<_i6.UserRepository>(_i6.UserRepository());
    gh.singleton<_i7.CitaService>(_i7.CitaService());
    gh.singleton<_i8.ClienteService>(_i8.ClienteService());
    gh.singleton<_i9.UserService>(_i9.UserService());
    return this;
  }
}
