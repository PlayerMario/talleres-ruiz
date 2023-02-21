import 'dart:convert';
import '../../main.dart';
import 'package:flutter/material.dart';

class MecanicoListItem extends StatelessWidget {
  const MecanicoListItem(
      {super.key, required this.mecanico, required this.rol});
  final MecanicoListaResponse? mecanico;
  final String rol;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: const Color.fromRGBO(43, 45, 66, 1),
      margin: const EdgeInsets.only(left: 50, top: 20, right: 50, bottom: 20),
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
                      utf8.decode(mecanico!.nombre!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      utf8.decode(mecanico!.email!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      utf8.decode(mecanico!.tlf!.codeUnits),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.center,
                    )),
              ],
            )),
        onPressed: () {
          print("Detalles del usuario ${mecanico!.id}");
          if (rol == "ADMIN") {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProviderDetallesMecanico(id: mecanico!.id!, rol: rol);
            }));
          } else {
            showSnackbar(
                "Solo un administrador puede acceder a los detalles", context);
          }
        },
      ),
    );
  }

  void showSnackbar(String msg, BuildContext context) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
