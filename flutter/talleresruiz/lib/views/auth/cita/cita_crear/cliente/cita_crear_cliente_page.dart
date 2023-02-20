import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../main.dart';

class CitaCrearClientePage extends StatefulWidget {
  const CitaCrearClientePage({Key? key}) : super(key: key);

  @override
  State<CitaCrearClientePage> createState() => _CitaCrearClientePage();
}

class _CitaCrearClientePage extends State<CitaCrearClientePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitaCrearClienteBloc, CitaCrearClienteState>(
        builder: (context, state) {
      switch (state.status) {
        case CitaCrearClienteStatus.failure:
          if (state.citaClienteCreada.subErrors != null) {
            return ListView.builder(
                itemCount: state.citaClienteCreada.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(
                      error: state.citaClienteCreada.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.citaClienteCreada);
          }
        case CitaCrearClienteStatus.success:
            return ProviderDetallesCita(id: state.citaClienteCreada!.id!);
          //return const ProviderClienteHome();
          //return const ClienteHomePage();
        //return DetallesNuevoCliente(cliente: state.clienteCreado!);
        case CitaCrearClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
