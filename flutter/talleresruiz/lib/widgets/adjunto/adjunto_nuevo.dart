import '../../main.dart';
import 'package:flutter/material.dart';

class NuevoAdjunto extends StatelessWidget {
  NuevoAdjunto({super.key, required this.id, required this.rol});
  final int id;
  final String rol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
      children: [
        Card(
            margin: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
                child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Nuevo mensaje",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.start,
                    )),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormularioNuevoMensaje(id: id, rol: rol);
                  }));
                })),
        Card(
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
                child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Nuevo fichero",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(237, 242, 244, 1)),
                      textAlign: TextAlign.start,
                    )),
                onPressed: () {
                  /*Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return FormularioNuevoFichero(
                                          id: id);
                                    }));*/
                })),
      ],
    ))));
  }
}
