import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../../main.dart';

class ProviderDetallesCita extends StatelessWidget {
  const ProviderDetallesCita({super.key, required this.id, required this.rol});
  final int id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider<CitaBloc>(
          create: (_) =>
              CitaBloc(citaService: citaService)..add(EventCitaDetalles(id)),
          child: CitaDetallesPage(rol: rol),
        ));
  }
}
