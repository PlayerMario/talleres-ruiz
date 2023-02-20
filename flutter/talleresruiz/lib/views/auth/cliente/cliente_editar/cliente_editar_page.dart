import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

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
    //return BlocBuilder<ClienteEditarBloc, ClienteEditarState>(
    return BlocBuilder<ClienteHomeBloc, ClienteHomeState>(
        builder: (context, state) {
      switch (state.status) {
        case ClienteHomeStatus.failure:
          if (state.clienteMe.subErrors! != null) {
            return ListView.builder(
                itemCount: state.clienteMe.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.clienteMe.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.clienteMe);
          }
        case ClienteHomeStatus.success:
          return const Center(child: CircularProgressIndicator());
        case ClienteHomeStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

}
