import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderEditarCitaCliente extends StatelessWidget {
  const ProviderEditarCitaCliente(
      {super.key, required this.cita, required this.id, required this.rol});
  final CitaCrearClienteBody cita;
  final int id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final citaService = getIt<CitaService>();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      body: BlocProvider(
        create: (_) => CitaBloc(citaService: citaService)
          ..add(EventEditarCitaCliente(cita, id)),
        child: CitaCrearClientePage(rol: rol),
      ),
    );
  }
}
