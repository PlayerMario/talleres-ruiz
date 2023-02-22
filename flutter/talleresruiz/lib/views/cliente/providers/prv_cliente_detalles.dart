import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderDetallesCliente extends StatelessWidget {
  const ProviderDetallesCliente({super.key, required this.id, required this.rol});
  final String id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    final clienteService = getIt<ClienteService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => ClienteBloc(clienteService: clienteService)
            ..add(EventDetallesCliente(id)),
          child: ClienteDetallesPage(rol: rol),
        ));
  }
}
