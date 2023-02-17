import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class MenuClientePage extends StatefulWidget {
  const MenuClientePage({Key? key}) : super(key: key);

  @override
  State<MenuClientePage> createState() => _MenuClientePage();
}

class _MenuClientePage extends State<MenuClientePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VistaClienteBloc, VistaClienteState>(
        builder: (context, state) {
      switch (state.status) {
        case VistaClienteStatus.failure:
          if (state.clienteMe.subErrors != null) {
            return ListView.builder(
                itemCount: state.clienteMe.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.clienteMe.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.clienteMe);
          }
        case VistaClienteStatus.success:
          if (state.clienteMe.roles[0] == "CLIENTE") {
            print("Login Cliene");
            return ClienteDetallesMe(clienteMe: state.clienteMe);
          } else {
            print("Login Admin-Mec");
            return Center(child: Text("Logueado ${state.clienteMe}"));
          }
        case VistaClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
