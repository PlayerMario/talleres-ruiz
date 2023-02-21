import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class AdMecMenu extends StatefulWidget {
  const AdMecMenu({super.key, required this.mecanicoMe});
  final MecanicoMeResponse mecanicoMe;

  @override
  State<AdMecMenu> createState() => _AdMecMenu();
}

class _AdMecMenu extends State<AdMecMenu> {
  int indices = 0;

  @override
  Widget build(BuildContext context) {
    final admecBloc = BlocProvider.of<AdMecBloc>(context);

    List<Widget> paginas = [
      DetallesAddMecLog(mecanicoMe: widget.mecanicoMe),
      const AdMecMenuPrincipal(),
      //const CitaNuevaAdMec()*/
    ];

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "PANEL DE TRABAJADOR",
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
                  'Editar datos usuario',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(43, 45, 66, 1)),
                )),
                onTap: () {
                  /*Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormularioEditarCliente(cliente: widget.clienteMe);
                  }));*/
                },
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'Cambiar contraseña',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(43, 45, 66, 1)),
                )),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormularioEditarPswd(
                        rol: widget.mecanicoMe.roles![0]);
                  }));
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
                  admecBloc.add(EventLogoutAdMec());
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomeMenuPage();
                  }), (route) => false);
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
                  label: 'Citas'),
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