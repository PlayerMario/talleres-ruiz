import 'package:flutter/material.dart';
import 'package:talleresruiz/main.dart';

class CitaMenu extends StatefulWidget {
  const CitaMenu({super.key, required this.citaDetalles, required this.rol});
  final CitaDetallesResponse citaDetalles;
  final String rol;

  @override
  State<CitaMenu> createState() => _CitaMenu();
}

class _CitaMenu extends State<CitaMenu> {
  int indices = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      DetallesCita(citaDetalles: widget.citaDetalles, rol: widget.rol),
      AdjuntosCita(adjuntos: widget.citaDetalles.chat),
      NuevoAdjunto(),
    ];

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "DETALLES DE LA CITA",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    if (widget.rol == "CLIENTE") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ProviderClienteHome();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ProviderAdMecHome();
                      }));
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(237, 242, 244, 1),
                  ));
            }),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: IndexedStack(
          index: indices,
          children: paginas,
        ),
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
                  label: 'Cita'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.comment_sharp,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_comment_sharp,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Agregar Chat'),
            ],
            currentIndex: indices,
            onTap: (int index) {
              setState(() {
                indices = index;
              });
            }));
  }
}
