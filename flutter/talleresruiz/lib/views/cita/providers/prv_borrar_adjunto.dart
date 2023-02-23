import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../../main.dart';

class ProviderBorrarAdjunto extends StatelessWidget {
  const ProviderBorrarAdjunto(
      {super.key,
      required this.idCita,
      required this.idAdj,
      required this.rol});
  final int idCita;
  final int idAdj;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider<CitaBloc>(
          create: (_) => CitaBloc(citaService: citaService)
            ..add(EventCitaBorrarAdj(idCita, idAdj)),
          child: CitaCrearClientePage(rol: rol),
        ));
  }
}
