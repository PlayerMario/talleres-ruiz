import 'package:flutter/material.dart';
import '../../main.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});
  @override
  State<HomeMenu> createState() => _HomeMenuPage();
}

class _HomeMenuPage extends State<HomeMenu> {
  final List<Widget> _paginas = [
    const HomePage(),
    const CrearClienteForm(),
    const LoginForm()
  ];
  int _indices = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            /*leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu_sharp,
                    color: Colors.black,
                  ));
            }),*/
            title: Center(child: Image.asset('assets/images/banner.png')),
            backgroundColor: const Color.fromRGBO(237, 242, 244, 1)),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.contain)),
          child: IndexedStack(
            index: _indices,
            children: _paginas,
          ),
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
                  icon: Icon(Icons.add_box_outlined,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Nuevo Usuario'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_sharp,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Iniciar Sesión'),
            ],
            currentIndex: _indices,
            onTap: (int index) {
              setState(() {
                _indices = index;
              });
            }));
  }
}