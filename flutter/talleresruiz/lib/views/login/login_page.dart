import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';
import 'package:talleresruiz/services/authentication/authentication_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.login});
  final LoginBody login;

  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "NUEVO USUARIO",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            /*leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(3, 37, 65, 1),
                  ));
            }),*/
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: BlocProvider<LoginBloc>(
          create: (_) =>
              LoginBloc(login: login, authenticationService: authService)
                ..add(LoginFetched(login)),
          child: const UsuarioLogPage(),
        ));
  }
}
