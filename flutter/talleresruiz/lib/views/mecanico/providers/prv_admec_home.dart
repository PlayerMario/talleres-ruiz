import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderAdMecHome extends StatelessWidget {
  const ProviderAdMecHome({super.key});

  @override
  Widget build(BuildContext context) {
    final adMecService = getIt<AdMecService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: BlocProvider(
          create: (_) =>
              AdMecBloc(adMecService: adMecService)..add(EventAdMecHome()),
          child: const AdMecHomePage(),
        ));
  }
}
