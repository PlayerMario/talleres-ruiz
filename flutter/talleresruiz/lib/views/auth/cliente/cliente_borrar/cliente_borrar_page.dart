import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

class ClienteBorrarPage extends StatefulWidget {
  const ClienteBorrarPage({Key? key}) : super(key: key);

  @override
  State<ClienteBorrarPage> createState() => _ClienteBorrarPage();
}

class _ClienteBorrarPage extends State<ClienteBorrarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteBorrarBloc, ClienteBorrarState>(
        builder: (context, state) {
      switch (state.status) {
        case ClienteBorrarStatus.failure:
          if (state.resp.subErrors != null) {
            return ListView.builder(
                itemCount: state.resp.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.resp.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.resp);
          }
        case ClienteBorrarStatus.success:
          return const HomeMenuPage();
        case ClienteBorrarStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
