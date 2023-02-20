import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderNuevaCitaCliente extends StatelessWidget {
  const ProviderNuevaCitaCliente({super.key, required this.cita});
  final CitaCrearClienteBody cita;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      body: BlocProvider(
        create: (_) => CitaBloc(citaService: citaService)
          ..add(EventCrearCitaCliente(cita)),
        child: const CitaCrearClientePage(),
      ),
    );
  }
}
