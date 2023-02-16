import 'package:flutter/material.dart';
import '../../main.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});
  final ErrorResponse error;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(43, 45, 66, 1),
        margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
        elevation: 10,
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "${error.statusCode!.toString()} - ${error.status!}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.message!.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(43, 45, 66, 1))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Volver',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}

class SubErrorData extends StatelessWidget {
  const SubErrorData({super.key, required this.error});
  final SubErrors error;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(43, 45, 66, 1),
        margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
        elevation: 15,
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "${error.message}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: error.field != null
                              ? Text(
                                  "Error en el campo ${error.field!.toUpperCase()}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                )
                              : const SizedBox(width: 0)),
                      Padding(
                          padding: const EdgeInsets.all(5),
                          child: error.field != null
                              ? Text(
                                  "Valor introducido: '${error.rejectedValue}'",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  textAlign: TextAlign.center,
                                )
                              : const SizedBox(width: 0)),
                    ],
                  ),
                ))));
  }
}
