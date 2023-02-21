import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderClientesListar extends StatelessWidget {
  const ProviderClientesListar({super.key});

  @override
  Widget build(BuildContext context) {
    final clienteService = getIt<ClienteService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => ClienteBloc(clienteService: clienteService)
            ..add(EventListarClientes()),
          child: const ClienteListarPage(),
        ));
  }
}
