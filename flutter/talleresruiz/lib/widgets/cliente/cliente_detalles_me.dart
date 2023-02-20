import 'dart:convert';
import 'package:flutter/material.dart';
import '../../main.dart';

/*class DetallesClienteLog extends StatefulWidget {
  const DetallesClienteLog({super.key, required this.clienteMe});
  final ClienteMeResponse clienteMe;

  @override
  State<DetallesClienteLog> createState() =>
      _DetallesClienteLog(clienteMe: clienteMe);
}

class _DetallesClienteLog extends State<DetallesClienteLog> {*/
//_DetallesClienteLog({super.key, required this.clienteMe});
//final ClienteMeResponse clienteMe;
class DetallesClienteLog extends StatelessWidget {
  //_DetallesClienteLog({required this.clienteMe});

  const DetallesClienteLog({super.key, required this.clienteMe});

  final ClienteMeResponse clienteMe;

  @override
  Widget build(BuildContext context) {
    Citas? ultimaCita = obtenerUltimaCitas(clienteMe.citas!);
    return Scaffold(
        body: Center(
            child: Column(
      children: [
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
                        child: Column(
                      children: [
                        SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.network(
                            '$baseUrl/auth/fichero/download/${clienteMe.avatar!}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.nombre!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.username!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.dni!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.email!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.tlf!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              utf8.decode(clienteMe.vehiculo!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ))))),
        Column(children: [
          const Text(
            "PRÓXIMA CITA:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(43, 45, 66, 1)),
            textAlign: TextAlign.center,
          ),
          CitaListItem(cita: ultimaCita)
        ])
      ],
    )));
  }
}
