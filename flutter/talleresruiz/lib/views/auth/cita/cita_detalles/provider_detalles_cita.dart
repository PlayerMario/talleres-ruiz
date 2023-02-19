import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../../../main.dart';

class ProviderDetallesCita extends StatelessWidget {
  const ProviderDetallesCita({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
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
        body: BlocProvider<CitaDetallesBloc>(
          create: (_) =>
              CitaDetallesBloc(id: id, citaService: citaService)
                ..add(CitaDetallesFetched(id)),
          child: const CitaDetallesPage(),
        ));
  }
}