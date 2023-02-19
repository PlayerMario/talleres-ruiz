import 'package:flutter/material.dart';
import '../../../../main.dart';

class ClienteMenu extends StatefulWidget {
  const ClienteMenu({super.key, required this.clienteMe});
  final ClienteMeResponse clienteMe;

  @override
  State<ClienteMenu> createState() => _ClienteMenu(/*clienteMe: clienteMe*/);
}

class _ClienteMenu extends State<ClienteMenu> {
  //_DetallesClienteLog({super.key, required this.clienteMe});
  //final ClienteMeResponse clienteMe;
  //_ClienteMenu({required this.clienteMe});

  /*static ClienteMeResponse clienteMe;
  final List<Widget> _paginas = [
    DetallesClienteLog(clienteMe: clienteMe),
    const FormularioCrearCliente(),
    FormularioLogin()
  ];
  int _indices = 0;*/

  int indices = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      DetallesClienteLog(clienteMe: widget.clienteMe),
      const ProviderClienteCitas(),
      FormularioLogin()
    ];
    
    return Scaffold(
        appBar: AppBar(
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
        ),
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
            currentIndex: indices,
            onTap: (int index) {
              setState(() {
                indices = index;
              });
            }));
  }
}
