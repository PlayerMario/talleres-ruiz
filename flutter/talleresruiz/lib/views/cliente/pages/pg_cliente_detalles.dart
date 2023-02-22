import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class ClienteDetallesPage extends StatefulWidget {
  const ClienteDetallesPage({super.key, required this.rol});
  final String rol;

  @override
  State<ClienteDetallesPage> createState() => _ClienteDetallesPage();
}

class _ClienteDetallesPage extends State<ClienteDetallesPage> {
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
          return DetallesClienteLog(clienteMe: state.response, rol: widget.rol);
        case ClienteStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
