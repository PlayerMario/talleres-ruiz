import 'package:flutter/material.dart';
import 'package:talleresruiz/crear_cliente/widgets/crear_cliente_screen.dart';
import 'package:talleresruiz/home/home.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'TALLERES RUIZ',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/crear-cliente': (context) => CrearClienteScreen(),
      }
    )
  );
}