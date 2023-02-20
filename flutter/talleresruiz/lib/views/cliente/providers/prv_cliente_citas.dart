import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/bloc/cliente/cliente_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderClienteCitas extends StatelessWidget {
  const ProviderClienteCitas({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteService = getIt<ClienteService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => ClienteBloc(clienteService: clienteService)
            ..add(EventCitasCliente()),
          child: const ClienteCitasPage(),
        ));
  }
}
