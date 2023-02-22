import '../../main.dart';
import 'package:flutter/material.dart';

class MenuListaAdMec extends StatelessWidget {
  const MenuListaAdMec({super.key, required this.rol});
  final String rol;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        child: Column(children: [
                      Card(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(43, 45, 66, 1)),
                              child: const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text(
                                    "CITAS",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.start,
                                  )),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProviderCitasListar(rol: rol);
                                }));
                              })),
                      Card(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(43, 45, 66, 1)),
                              child: const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text(
                                    "CLIENTES",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.start,
                                  )),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ProviderClientesListar();
                                }));
                              })),
                      Card(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(43, 45, 66, 1)),
                              child: const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text(
                                    "MECÁNICOS",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.start,
                                  )),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProviderMecanicosListar(rol: rol);
                                }));
                              })),
                      Card(
                          margin: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 20),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(43, 45, 66, 1)),
                              child: const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Text(
                                    "TRABAJADORES",
                                    style: TextStyle(
                                        fontSize: 25,
                                        color:
                                            Color.fromRGBO(237, 242, 244, 1)),
                                    textAlign: TextAlign.start,
                                  )),
                              onPressed: () {
                                if (rol == "ADMIN") {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const AdMecMenuTrbj();
                                  }));
                                } else {
                                  showSnackbar(
                                      "Sólo un ADMIN puede acceder", context);
                                }
                              })),
                    ]))))));
  }
}
