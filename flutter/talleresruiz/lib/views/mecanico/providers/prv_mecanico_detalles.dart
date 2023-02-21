import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderDetallesMecanico extends StatelessWidget {
  const ProviderDetallesMecanico({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final adMecService = getIt<AdMecService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => AdMecBloc(adMecService: adMecService)
            ..add(EventDetallesMecanico(id)),
          child: const MecanicoDetallesPage(),
        ));
  }
}
