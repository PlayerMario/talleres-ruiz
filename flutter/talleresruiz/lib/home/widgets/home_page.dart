import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_sharp,
                    color: Colors.black,
                  ));
            }),
            title: Center(child: Image.asset('assets/images/banner.png')),
            backgroundColor: Colors.white),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain)),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 65,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Center(
                      child: Icon(Icons.car_repair_sharp,
                          color: Colors.white, size: 35)),
                ),
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'NUEVA CITA',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                onTap: () {
                  print('NUEVA CITA');
                  //Navigator.pushNamed(context, '/movies');
                },
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'CREAR USUARIO',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                onTap: () {
                  print('CREAR USUARIO');
                  Navigator.pushNamed(context, '/crear-cliente');
                },
              ),
              ListTile(
                title: const Center(
                    child: Text(
                  'INICIAR SESIÓN',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
                onTap: () {
                  print('INICIAR SESION');
                  //Navigator.pushNamed(context, '/movies');
                },
              ),
            ],
          ),
        ));
  }
}
