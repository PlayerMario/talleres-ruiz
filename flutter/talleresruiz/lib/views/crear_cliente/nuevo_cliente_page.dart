import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class NuevoClienteScreen extends StatefulWidget {
  const NuevoClienteScreen({Key? key}) : super(key: key);

  @override
  State<NuevoClienteScreen> createState() => NuevoClienteDetails();
}

class NuevoClienteDetails extends State<NuevoClienteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrearClienteBloc, CrearClienteState>(
        builder: (context, state) {
      switch (state.status) {
        case CrearClienteStatus.failure:
          if (state.clienteCreado.subErrors! != null) {
            return ListView.builder(
                itemCount: state.clienteCreado.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.clienteCreado.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.clienteCreado);
          }
        case CrearClienteStatus.success:
          return NuevoCliente(cliente: state.clienteCreado!);
        case CrearClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
