import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderLogin extends StatelessWidget {
  const ProviderLogin({super.key, required this.login});
  final UserLoginBody login;

  @override
  Widget build(BuildContext context) {
    final authService = getIt<UserService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        /*appBar: AppBar(
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
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),*/
        body: BlocProvider<UserLoginBloc>(
          create: (_) =>
              UserLoginBloc(login: login, userService: authService)
                ..add(UserLoginFetched(login)),
          child: const LoginPage(),
        ));
  }
}
