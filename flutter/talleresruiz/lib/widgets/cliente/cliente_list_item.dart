import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class ClienteListItem extends StatelessWidget {
  const ClienteListItem({super.key, required this.cliente, required this.rol});
  final ClienteListaResponse? cliente;
  final String rol;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: const Color.fromRGBO(43, 45, 66, 1),
      margin: const EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
      elevation: 15,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      utf8.decode(cliente!.nombre!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      utf8.decode(cliente!.email!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      utf8.decode(cliente!.tlf!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
              ],
            )),
        onPressed: () {
          print("Detalles del usuario ${cliente!.id}");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProviderDetallesCliente(id: cliente!.id!, rol: rol);
            }));
        },
      ),
    );
  }
}
