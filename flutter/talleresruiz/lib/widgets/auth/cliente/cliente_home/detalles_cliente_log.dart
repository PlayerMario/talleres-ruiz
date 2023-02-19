import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../main.dart';

/*class DetallesClienteLog extends StatefulWidget {
  const DetallesClienteLog({super.key, required this.clienteMe});
  final ClienteMeResponse clienteMe;

  @override
  State<DetallesClienteLog> createState() =>
      _DetallesClienteLog(clienteMe: clienteMe);
}

class _DetallesClienteLog extends State<DetallesClienteLog> {*/
//_DetallesClienteLog({super.key, required this.clienteMe});
//final ClienteMeResponse clienteMe;
class DetallesClienteLog extends StatelessWidget {
  //_DetallesClienteLog({required this.clienteMe});

  const DetallesClienteLog({super.key, required this.clienteMe});

  final ClienteMeResponse clienteMe;

  /*final List<Widget> _paginas = [
    const HomePage(),
    const FormularioCrearCliente(),
    FormularioLogin()
  ];
  int _indices = 0;*/

  @override
  Widget build(BuildContext context) {
    Citas? ultimaCita = obtenerUltimaCitas(clienteMe.citas!);
    return Scaffold(
        /*appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "PANEL DE CLIENTE",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_sharp,
                    color: Color.fromRGBO(237, 242, 244, 1),
                  ));
            }),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 150,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(43, 45, 66, 1),
                  ),
                  child: Center(
                      child: Icon(Icons.car_repair,
                          color: Color.fromRGBO(237, 242, 244, 1), size: 35)),
                ),
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'Editar perfil',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(43, 45, 66, 1)),
                )),
                onTap: () {
                  //Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(43, 45, 66, 1)),
                )),
                onTap: () {
                  //Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'Eliminar usuario',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(43, 45, 66, 1)),
                )),
                onTap: () {
                  //Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ),*/
        body: Center(
            child: Column(
      children: [
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shadowColor: const Color.fromRGBO(43, 45, 66, 1),
            margin:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 40),
            elevation: 5,
            child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                        child: Column(
                      children: [
                        SizedBox(
                          width: 125,
                          height: 125,
                          child: Image.network(
                            '$baseUrl/auth/fichero/download/${clienteMe.avatar!}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.nombre!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.username!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.dni!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.email!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Text(
                              utf8.decode(clienteMe.tlf!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Text(
                              utf8.decode(clienteMe.vehiculo!.codeUnits),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ))))),
        Column(children: [
          const Text(
            "PRÓXIMA CITA:",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromRGBO(43, 45, 66, 1)),
            textAlign: TextAlign.center,
          ),
          CitaListItem(cita: ultimaCita)
        ]),
        /*IndexedStack(
              index: _indices,
              children: _paginas,
            )*/
      ],
    )) /*,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1),
            unselectedItemColor: const Color.fromRGBO(237, 242, 244, 1),
            selectedItemColor: const Color.fromRGBO(227, 1, 15, 1),
            selectedIconTheme:
                const IconThemeData(color: Color.fromRGBO(227, 1, 15, 1)),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                  icon:
                      Icon(Icons.home, color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Inicio'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_rounded,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Mis Citas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.post_add_rounded,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Nueva Cita'),
            ],
            currentIndex: _indices,
            onTap: (int index) {
              setState(() {
                _indices = index;
              });
            })*/
        );
  }
}
