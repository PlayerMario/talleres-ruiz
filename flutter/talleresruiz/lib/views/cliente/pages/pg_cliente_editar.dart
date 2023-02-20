import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/bloc/cliente/cliente_bloc.dart';
import '../../../main.dart';

class ClienteEditarPage extends StatefulWidget {
  const ClienteEditarPage({Key? key}) : super(key: key);

  @override
  State<ClienteEditarPage> createState() => _ClienteEditarPage();
}

class _ClienteEditarPage extends State<ClienteEditarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteBloc, ClienteState>(builder: (context, state) {
      switch (state.status) {
        case ClienteStatus.failure:
          if (state.response.subErrors != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case ClienteStatus.success:
          return ClienteMenu(clienteMe: state.response);
        case ClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
