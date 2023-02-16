import 'package:flutter/material.dart';
import '../../main.dart';

class ErrorData extends StatelessWidget {
  const ErrorData({super.key, required this.error});
  final ErrorResponse error;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(1, 180, 228, 1),
        margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
        elevation: 15,
        child: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.path!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.statusCode!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.status!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.message!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            error.date! as String,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ))));
  }
}