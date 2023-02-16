import '../../main.dart';
import 'package:flutter/material.dart';

class NuevoCliente extends StatelessWidget {
  const NuevoCliente({super.key, required this.cliente});
  final CrearClienteResponse cliente;

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
                      Image.network('https://robohash.org/${cliente.username}'),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.nombre!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.username!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.dni!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.email!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.tlf!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            cliente.vehiculo!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                            textAlign: TextAlign.center,
                          )),
                    ],
                  ),
                ))));
  }
}
