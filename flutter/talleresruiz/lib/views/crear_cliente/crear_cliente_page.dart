import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/main.dart';

class CrearClientePage extends StatelessWidget {
  const CrearClientePage({super.key, required this.cliente});
  final CrearClienteBody cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
            title: const Text(
              "NUEVO USUARIO",
              style: TextStyle(color: Color.fromRGBO(237, 242, 244, 1), ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(3, 37, 65, 1),
                  ));
            }),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: BlocProvider(
          create: (_) => CrearClienteBloc(cliente: cliente)
            ..add(CrearClienteFetched(cliente)),
          child: const NuevoClienteScreen(),
        ));
  }
}
