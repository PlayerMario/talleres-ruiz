import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class DetallesChat extends StatelessWidget {
  const DetallesChat(
      {super.key, required this.chat, required this.idCita, required this.rol});
  final Chat chat;
  final int idCita;
  final String rol;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: const Color.fromRGBO(43, 45, 66, 1),
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 5),
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
                                : "Sin asignar",
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(43, 45, 66, 1)),
                            textAlign: TextAlign.start,
                          )),
                      chat.fichero!
                          ? SizedBox(
                              width: 150,
                              height: 450,
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
                                fontSize: 16,
                                color: Color.fromRGBO(43, 45, 66, 1)),
                            textAlign: TextAlign.end,
                          ))
                    ])))),
        Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          elevation: 0,
                          backgroundColor:
                              const Color.fromRGBO(255, 255, 255, 0))
                      .copyWith(
                    overlayColor: MaterialStateProperty.all(
                        const Color.fromRGBO(255, 255, 255, 0)),
                  ),
                  child: const Icon(Icons.delete_outline,
                      color: Color.fromRGBO(43, 45, 66, 1), size: 22),
                  onPressed: () {
                    showSnackbar(
                        "Deja pulsado para borrar el mensaje", context);
                  },
                  onLongPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProviderBorrarAdjunto(
                          idCita: idCita, idAdj: chat.id!, rol: rol);
                    }));
                  },
                )))
      ],
    );
  }
}
