import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class DetallesChat extends StatelessWidget {
  DetallesChat({super.key, required this.chat});

  Chat chat;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: const Color.fromRGBO(43, 45, 66, 1),
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        elevation: 5,
        child: Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(
                        chat.autor != null
                            ? utf8.decode(chat.autor!.codeUnits)
                            : "Mecánico: \nSin asignar",
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromRGBO(43, 45, 66, 1)),
                        textAlign: TextAlign.start,
                      )),
                  chat.fichero!
                      ? SizedBox(
                          width: 150,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Image.network(
                              '$baseUrl/auth/fichero/download/${chat.contenido!}',
                              fit: BoxFit.cover,
                            ),
                          ))
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Text(
                            utf8.decode(chat.contenido!.codeUnits),
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(43, 45, 66, 1)),
                            textAlign: TextAlign.start,
                          )),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Text(
                        utf8.decode(chat.fechaHora!.codeUnits),
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromRGBO(43, 45, 66, 1)),
                        textAlign: TextAlign.end,
                      ))
                ]))));
  }
}
