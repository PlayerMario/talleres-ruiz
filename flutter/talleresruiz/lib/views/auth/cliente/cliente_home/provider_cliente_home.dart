import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../../main.dart';


class ProviderClienteHome extends StatelessWidget {
  const ProviderClienteHome({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<UserService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "PANEL DE CLIENTE",
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
        body: BlocProvider(
          create: (_) => VistaClienteBloc(authenticationService: authService)
            ..add(VistaClienteFetched()),
          child: const ClienteHomePage(),
        ));
  }
}
