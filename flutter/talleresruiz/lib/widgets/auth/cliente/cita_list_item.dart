import 'dart:convert';
import '../../../main.dart';
import 'package:flutter/material.dart';

class CitaListItem extends StatelessWidget {
  const CitaListItem({super.key, required this.cita});
  final Citas? cita;

  @override
  Widget build(BuildContext context) {
    if (cita != null) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("PRÓXIMA CITA:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Mecánico: \n${utf8.decode(cita!.mecanico!.codeUnits)}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Fecha y hora: \n${utf8.decode(cita!.fechaHora!.codeUnits)}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      "Estado: \n${utf8.decode(cita!.estado!.codeUnits)}",
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
              ],
            )),
        onPressed: () {
          print("A DETALLES DE LA CITA");
        },
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        child: const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Sin citas recientes",
              style: TextStyle(
                  fontSize: 17, color: Color.fromRGBO(237, 242, 244, 1)),
              textAlign: TextAlign.center,
            )),
        onPressed: () {
          print("A DETALLES DE LA CITA");
        },
      );
    }
  }
}
