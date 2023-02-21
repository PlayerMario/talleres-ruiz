import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/main.dart';

class ProviderAdMecEditar extends StatelessWidget {
  const ProviderAdMecEditar({super.key, required this.adMec, required this.id});
  final AdMecEditarBody adMec;
  final String id;

  @override
  Widget build(BuildContext context) {
    final adMecService = getIt<AdMecService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) => AdMecBloc(adMecService: adMecService)
            ..add(EventEditarAdMec(adMec, id)),
          child: const AdMecEditarPage(),
        ));
  }
}
