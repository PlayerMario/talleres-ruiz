import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import '../../../main.dart';

class ProviderMecanicosListar extends StatelessWidget {
  const ProviderMecanicosListar({super.key});

  @override
  Widget build(BuildContext context) {
    final adMecService = getIt<AdMecService>();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "LISTA MECÁNICOS",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(237, 242, 244, 1),
                  ));
            }),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: BlocProvider(
          create: (_) =>
              ListasMecanicoBloc(adMecService: adMecService, nextPage: 0)
                ..add(EventListaMecanicos()),
          child: const MecanicoListarPage(),
        ));
  }
}
