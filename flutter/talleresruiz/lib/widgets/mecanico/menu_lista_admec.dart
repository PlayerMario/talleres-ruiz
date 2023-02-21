import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import 'package:flutter/material.dart';

class MenuListaAdMec extends StatelessWidget {
  const MenuListaAdMec({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Card(
          margin:
              const EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
              child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "CLIENTES",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(237, 242, 244, 1)),
                    textAlign: TextAlign.start,
                  )),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProviderClientesListar();
                }));
              })),
      Card(
          margin:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
              child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "MECÁNICOS",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(237, 242, 244, 1)),
                    textAlign: TextAlign.start,
                  )),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProviderMecanicosListar();
                }));
              })),
      Card(
          margin:
              const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
              child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "CITAS",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(237, 242, 244, 1)),
                    textAlign: TextAlign.start,
                  )),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProviderCitasListar();
                }));
              })),
    ])));
  }
}
