import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

class CrearClientePage extends StatefulWidget {
  const CrearClientePage({Key? key}) : super(key: key);

  @override
  State<CrearClientePage> createState() => _CrearClientePage();
}

class _CrearClientePage extends State<CrearClientePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteCrearBloc, ClienteCrearState>(
        builder: (context, state) {
      switch (state.status) {
        case ClienteCrearStatus.failure:
          if (state.clienteCreado.subErrors! != null) {
            return ListView.builder(
                itemCount: state.clienteCreado.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.clienteCreado.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.clienteCreado);
          }
        case ClienteCrearStatus.success:
          return DetallesNuevoCliente(cliente: state.clienteCreado!);
        case ClienteCrearStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
