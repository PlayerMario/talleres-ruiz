import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/main.dart';

class CrearClientePage extends StatelessWidget {
  const CrearClientePage({super.key, required this.cliente});
  final CrearClienteBody cliente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(3, 37, 65, 1),
        appBar: AppBar(
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
            backgroundColor: Colors.white),
        body: BlocProvider(
          create: (_) => CrearClienteBloc(cliente: cliente)..add(CrearClienteFetched(cliente)),
          child: const NuevoClienteScreen(),
        ));
  }
}