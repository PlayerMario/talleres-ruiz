import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderLogin extends StatelessWidget {
  const ProviderLogin({super.key, required this.login});
  final UserLoginBody login;

  @override
  Widget build(BuildContext context) {
    final userService = getIt<UserService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) =>
              UserBloc(userService: userService)..add(EventLoginUser(login)),
          child: const LoginPage(),
        ));
  }
}
