import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class DetallesNuevoAdMec extends StatelessWidget {
  DetallesNuevoAdMec({super.key, required this.adMec});
  final MecanicoMeResponse adMec;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "INFORMACIÓN TRABAJADOR",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: Center(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shadowColor: const Color.fromRGBO(43, 45, 66, 1),
                elevation: 5,
                color: const Color.fromRGBO(43, 45, 66, 1),
                child: SingleChildScrollView(
                    child: Container(
                        padding: const EdgeInsets.all(20),
                        child: SizedBox(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                height: 150,
                                child: Image.network(
                                  '$baseUrl/auth/fichero/download/${adMec.avatar!}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    utf8.decode(adMec.nombre!.codeUnits),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    utf8.decode(adMec.username!.codeUnits),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    utf8.decode(adMec.dni!.codeUnits),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    utf8.decode(adMec.email!.codeUnits),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    utf8.decode(adMec.tlf!.codeUnits),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    adMec.roles!.length == 2
                                        ? 'Administrador - Mecánico'
                                        : 'Mecánico',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.center,
                                  )),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(
                                                237, 242, 244, 1))),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const ProviderAdMecHome();
                                  }));
                                },
                                child: const Text(
                                  'Volver',
                                  style: TextStyle(
                                      color: Color.fromRGBO(43, 45, 66, 1),
                                      fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ))))));
  }
}
