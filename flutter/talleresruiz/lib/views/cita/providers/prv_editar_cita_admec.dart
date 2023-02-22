import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderEditarCitaAdMec extends StatelessWidget {
  const ProviderEditarCitaAdMec(
      {super.key, required this.cita, required this.id, required this.rol});
  final CitaEditarAdMecBody cita;
  final int id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      body: BlocProvider(
        create: (_) => CitaBloc(citaService: citaService)
          ..add(EventEditarCitaAdMec(cita, id)),
        child: CitaCrearClientePage(rol: rol),
      ),
    );
  }
}
