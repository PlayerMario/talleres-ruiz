import 'package:flutter/material.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'main.dart';
export './bloc/bloc.dart';
export './models/models.dart';
export './repositories/repositories.dart';
export './views/views.dart';
export './widgets/widgets.dart';
export './services/services.dart';
export './config/config.dart';
export './utils/utils.dart';

void main() {
  setupAsyncDependencies();
  configureDependencies();

  runApp(MaterialApp(
      title: 'TALLERES RUIZ',
      initialRoute: '/',
      routes: {'/': (context) => const HomeMenuPage()}));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
      body: Container(
        margin: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain)),
      ),
    );
  }
}
