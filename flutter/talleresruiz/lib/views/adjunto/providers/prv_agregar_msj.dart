import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderMsjAdjuntoCrear extends StatelessWidget {
  const ProviderMsjAdjuntoCrear(
      {super.key, required this.adjunto, required this.id, required this.rol});
  final AdjuntoMsjBody adjunto;
  final int id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => CitaBloc(citaService: citaService)
            ..add(EventAgregarMsj(adjunto, id)),
          child: CitaCrearClientePage(rol: rol),
        ));
  }
}
