import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderClienteEditar extends StatelessWidget {
  const ProviderClienteEditar({super.key, required this.cliente});
  final ClienteEditarBody cliente;

  @override
  Widget build(BuildContext context) {
    final clienteService = getIt<ClienteService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          //create: (_) => ClienteEditarBloc(cliente: cliente, clienteService: clienteService)
          create: (_) =>
              ClienteHomeBloc(cliente: cliente, clienteService: clienteService)
                ..add(ClienteEditarFetched(cliente)),
          child: const ClienteEditarPage(),
        ));
  }
}
