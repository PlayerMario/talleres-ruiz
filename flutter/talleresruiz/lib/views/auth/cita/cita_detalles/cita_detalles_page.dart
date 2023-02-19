import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

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
    return BlocBuilder<CitaDetallesBloc, CitaDetallesState>(
        builder: (context, state) {
      switch (state.status) {
        case CitaDetallesStatus.failure:
          if (state.citaDetalles.subErrors != null) {
            return ListView.builder(
                itemCount: state.citaDetalles.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(
                      error: state.citaDetalles.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.citaDetalles);
          }
        case CitaDetallesStatus.success:
          return CitaMenu(citaDetalles: state.citaDetalles);
        case CitaDetallesStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
