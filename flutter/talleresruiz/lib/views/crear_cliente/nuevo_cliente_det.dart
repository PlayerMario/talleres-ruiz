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
          return ErrorData(error: state.clienteCreado);
        case CrearClienteStatus.success:
          return NuevoCliente(cliente: state.clienteCreado!);
        case CrearClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
