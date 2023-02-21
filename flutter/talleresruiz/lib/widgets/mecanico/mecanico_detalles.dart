import 'dart:convert';
import 'package:flutter/material.dart';
import '../../main.dart';

class DetallesMecanico extends StatelessWidget {
  const DetallesMecanico({super.key, required this.mecanico});
  final MecanicoMeResponse mecanico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "DETALLES DEL TRABAJADOR",
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
        body: Center(
            child: Column(children: [
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shadowColor: const Color.fromRGBO(43, 45, 66, 1),
              margin: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 40),
              elevation: 5,
              color: const Color.fromRGBO(43, 45, 66, 1),
              child: SingleChildScrollView(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: SizedBox(
                          child: Column(
                        children: [
                          SizedBox(
                            width: 125,
                            height: 125,
                            child: Image.network(
                              '$baseUrl/auth/fichero/download/${mecanico.avatar!}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                utf8.decode(mecanico.nombre!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                utf8.decode(mecanico.username!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                utf8.decode(mecanico.dni!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                utf8.decode(mecanico.email!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                utf8.decode(mecanico.tlf!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                mecanico.roles!.length == 2
                                    ? 'Administrador - Mecánico'
                                    : 'Mecánico',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      )))))
        ])));
  }
}
