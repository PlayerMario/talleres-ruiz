import 'dart:convert';
import 'package:flutter/material.dart';
import '../../main.dart';

class DetallesAddMecLog extends StatelessWidget {
  const DetallesAddMecLog({super.key, required this.mecanicoMe});
  final MecanicoMeResponse mecanicoMe;

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.all(40),
                    child: SizedBox(
                        child: Column(
                      children: [
                        SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.network(
                            '$baseUrl/auth/fichero/download/${mecanicoMe.avatar!}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              utf8.decode(mecanicoMe.nombre!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(mecanicoMe.username!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(mecanicoMe.dni!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(mecanicoMe.email!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              utf8.decode(mecanicoMe.tlf!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color.fromRGBO(43, 45, 66, 1)),
                              textAlign: TextAlign.center,
                            ))
                      ],
                    )))))
      ],
    )));
  }
}
