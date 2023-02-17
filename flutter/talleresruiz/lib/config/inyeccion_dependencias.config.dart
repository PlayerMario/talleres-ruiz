// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:talleresruiz/repositories/cliente/cliente_repository.dart'
    as _i3;
import 'package:talleresruiz/repositories/crear_cliente/crear_cliente_repo.dart'
    as _i4;
import 'package:talleresruiz/repositories/log/log_repo.dart' as _i5;
import 'package:talleresruiz/services/authentication/authentication_service.dart'
    as _i6;

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
    gh.singleton<_i3.ClienteRepository>(_i3.ClienteRepository());
    gh.singleton<_i4.CrearClienteRepository>(_i4.CrearClienteRepository());
    gh.singleton<_i5.LoginRepository>(_i5.LoginRepository());
    gh.singleton<_i6.JwtAuthenticationService>(_i6.JwtAuthenticationService());
    return this;
  }
}
