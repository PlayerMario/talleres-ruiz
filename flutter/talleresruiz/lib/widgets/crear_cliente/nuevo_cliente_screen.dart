import '../../main.dart';
import 'package:flutter/material.dart';

class NuevoCliente extends StatelessWidget {
  const NuevoCliente({super.key, required this.cliente});
  final CrearClienteResponse cliente;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: const Color.fromRGBO(43, 45, 66, 1),
            //margin: const EdgeInsets.only(left: 80, top: 25),
            elevation: 5,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            //child: Image.network('http://localhost:8080/auth/fichero/download/${cliente.avatar!}', fit: BoxFit.cover),
                            child: Image.network(
                              'http://10.0.2.2:8080/auth/fichero/download/${cliente.avatar!}',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.nombre!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.username!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.dni!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.email!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.tlf!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                cliente.vehiculo!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                                textAlign: TextAlign.center,
                              )),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(43, 45, 66, 1))),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return const HomePage();
                              }));
                            },
                            child: const Text(
                              'Volver',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    )))));
  }
}
