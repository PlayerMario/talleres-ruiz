import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class CitaDetallesPage extends StatefulWidget {
  const CitaDetallesPage({Key? key}) : super(key: key);

  @override
  State<CitaDetallesPage> createState() => _CitaDetallesPage();
}

class _CitaDetallesPage extends State<CitaDetallesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CitaBloc, CitaState>(builder: (context, state) {
      switch (state.status) {
        case CitaStatus.failure:
          if (state.response.subErrors != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case CitaStatus.success:
          return CitaMenu(citaDetalles: state.response);
        case CitaStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
