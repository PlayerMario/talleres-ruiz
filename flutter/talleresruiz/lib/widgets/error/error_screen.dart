import 'dart:convert';
import 'package:flutter/material.dart';
import '../../main.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});
  final ErrorResponse error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "ERROR",
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
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),*/
        body: Center(child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: const Color.fromRGBO(43, 45, 66, 1),
            //margin: const EdgeInsets.only(left: 50, top: 25, right: 25),
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
                                "${utf8.decode(error.statusCode!.toString().codeUnits)} - ${utf8.decode(error.status!.codeUnits)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                utf8.decode(
                                    error.message!.toString().codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                    ))))));
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
                    child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                  Expanded(
                      flex: 9,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                utf8.decode(error.message!.codeUnits),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(5),
                              child: error.field != null
                                  ? Text(
                                      "Error en el campo ${utf8.decode(error.field!.toUpperCase().codeUnits)}",
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
                                      "Valor introducido: '${utf8.decode(error.rejectedValue!.codeUnits)}'",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      textAlign: TextAlign.center,
                                    )
                                  : const SizedBox(width: 0)),
                        ],
                      ))
                ])
                    /*child:*/
                    ))));
  }
}
