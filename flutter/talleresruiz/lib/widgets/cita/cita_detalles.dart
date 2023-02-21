import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import 'package:flutter/material.dart';

class DetallesCita extends StatelessWidget {
  DetallesCita({super.key, required this.citaDetalles});
  CitaDetallesResponse citaDetalles;

  @override
  Widget build(BuildContext context) {
    final citaBloc = BlocProvider.of<CitaBloc>(context);
    return Scaffold(
        body: Center(
            child: Column(children: [
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shadowColor: const Color.fromRGBO(43, 45, 66, 1),
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
          elevation: 5,
          child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          citaDetalles.mecanico != null
                              ? "Mecánico: \n${utf8.decode(citaDetalles.mecanico!.codeUnits)}"
                              : "Mecánico: \nSin asignar",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(43, 45, 66, 1)),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Cliente: \n${utf8.decode(citaDetalles.cliente!.codeUnits)}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(43, 45, 66, 1)),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Vehículo: \n${utf8.decode(citaDetalles.vehiculo!.codeUnits)}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(43, 45, 66, 1)),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text(
                          "Fecha y hora: \n${utf8.decode(citaDetalles.fechaHora!.codeUnits)}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(43, 45, 66, 1)),
                          textAlign: TextAlign.center,
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Text(
                          "Estado: \n${utf8.decode(citaDetalles.estado!.codeUnits)}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromRGBO(43, 45, 66, 1)),
                          textAlign: TextAlign.center,
                        ))
                  ]))))),
      Card(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
              child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Modificar cita",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(237, 242, 244, 1)),
                    textAlign: TextAlign.start,
                  )),
              onPressed: () {
                if (citaDetalles.estado! != "Terminada" &&
                    citaDetalles.estado! != "Proceso") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CitaEditarCliente(
                      cita: citaDetalles,
                    );
                  }));
                } else {
                  showSnackbar(
                      "No se puede modificar una cita terminada o en proceso",
                      context);
                }
              })),
      Card(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
              child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Cancelar cita",
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(237, 242, 244, 1)),
                    textAlign: TextAlign.start,
                  )),
              onPressed: () {
                if (citaDetalles.estado! != 'Terminada' &&
                    citaDetalles.estado! != 'Proceso') {
                  citaBloc.add(EventBorrarCitaCliente(citaDetalles.id!));
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProviderClienteHome();
                  }));
                } else {
                  showSnackbar(
                      "No se puede eliminar una cita terminada o en proceso",
                      context);
                }
              }))
    ])));
  }

  void showSnackbar(String msg, BuildContext context) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}