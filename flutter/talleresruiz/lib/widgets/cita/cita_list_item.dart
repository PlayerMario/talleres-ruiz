import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class CitaListItem extends StatelessWidget {
  const CitaListItem({super.key, required this.cita});
  final CitaListaResponse? cita;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(43, 45, 66, 1),
        margin: const EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
        elevation: 15,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
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
                        "Cliente: \n${utf8.decode(cita!.cliente!.codeUnits)}",
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
            print("A DETALLES DE LA CITA ${cita!.id}");
            /*Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProviderDetallesCita(id: cita!.id!);
            }));*/
          },
        ));
  }
}
