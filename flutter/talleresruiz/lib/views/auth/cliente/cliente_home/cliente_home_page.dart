import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

class ClienteHomePage extends StatefulWidget {
  const ClienteHomePage({Key? key}) : super(key: key);

  @override
  State<ClienteHomePage> createState() => _ClienteHomePage();
}

class _ClienteHomePage extends State<ClienteHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteHomeBloc, ClienteHomeState>(
        builder: (context, state) {
      switch (state.status) {
        case ClienteHomeStatus.failure:
          if (state.clienteMe.subErrors != null) {
            return ListView.builder(
                itemCount: state.clienteMe.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.clienteMe.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.clienteMe);
          }
        case ClienteHomeStatus.success:
          if (state.clienteMe.roles[0] == "CLIENTE") {
            print("Login Cliene");
            //return DetallesClienteLog(clienteMe: state.clienteMe);
            return ClienteMenu(clienteMe: state.clienteMe);
          } else {
            print("Login Admin-Mec");
            return Center(child: Text("Logueado ${state.clienteMe}"));
          }
        case ClienteHomeStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
