import '../../main.dart';
import 'package:flutter/material.dart';

class AdjuntosCita extends StatelessWidget {
  const AdjuntosCita(
      {super.key,
      required this.adjuntos,
      required this.idCita,
      required this.rol});

  final List<Chat>? adjuntos;
  final int idCita;
  final String rol;

  @override
  Widget build(BuildContext context) {
    if (adjuntos != null) {
      return ListView.builder(
          itemCount: adjuntos!.length,
          itemBuilder: (BuildContext context, int index) {
            return DetallesChat(
                chat: adjuntos![index], idCita: idCita, rol: rol);
          });
    } else {
      return Center(
          child: Card(
              color: const Color.fromRGBO(43, 45, 66, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              shadowColor: const Color.fromRGBO(43, 45, 66, 1),
              margin: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              elevation: 5,
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: const SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            "Chat vacío",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromRGBO(237, 242, 244, 1)),
                            textAlign: TextAlign.center,
                          ))))));
    }
  }
}
