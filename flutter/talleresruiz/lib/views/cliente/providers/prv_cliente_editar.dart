import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/bloc/cliente/cliente_bloc.dart';
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
          create: (_) => ClienteBloc(clienteService: clienteService)
            ..add(EventEditarCliente(cliente)),
          child: const ClienteEditarPage(),
        ));
  }
}
