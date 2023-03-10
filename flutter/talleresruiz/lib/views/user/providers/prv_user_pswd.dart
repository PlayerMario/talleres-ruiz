import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderUserEditarPswd extends StatelessWidget {
  const ProviderUserEditarPswd(
      {super.key, required this.pswd, required this.rol});
  final UserEditarPswdBody pswd;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final userService = getIt<UserService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => UserBloc(userService: userService)
            ..add(EventUserEditarPswd(pswd)),
          child: UserEditarPswdPage(rol: rol),
        ));
  }
}
