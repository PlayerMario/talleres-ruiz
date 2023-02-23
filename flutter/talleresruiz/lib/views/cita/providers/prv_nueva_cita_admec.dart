import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderNuevaCitaAdMec extends StatelessWidget {
  const ProviderNuevaCitaAdMec(
      {super.key, required this.cita, required this.rol});
  final CitaCrearAdMecBody cita;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      body: BlocProvider(
        create: (_) =>
            CitaBloc(citaService: citaService)..add(EventCrearCitaAdMec(cita)),
        child: CitaCrearClientePage(rol: rol),
      ),
    );
  }
}
