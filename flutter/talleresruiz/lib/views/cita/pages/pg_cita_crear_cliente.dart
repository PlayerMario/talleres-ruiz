import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class CitaCrearClientePage extends StatefulWidget {
  const CitaCrearClientePage({super.key, required this.rol});
  final String rol;

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
          return ProviderDetallesCita(id: state.response!.id!, rol: widget.rol);
        case CitaStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
