import 'package:flutter/material.dart';
import 'package:talleresruiz/home/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'TALLERES RUIZ',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        //'/cita': (context) => const (),
        //'/cliente': (context) => const (),
        //'/mecanico': (context) => const (),
      }
    )
  );
}