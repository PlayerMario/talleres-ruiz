import 'package:flutter/material.dart';
import '../../../main.dart';

class AdMecMenuTrbj extends StatefulWidget {
  const AdMecMenuTrbj({super.key});

  @override
  State<AdMecMenuTrbj> createState() => _AdMecMenuTrbj();
}

class _AdMecMenuTrbj extends State<AdMecMenuTrbj> {
  int indices = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      const FormularioCrearAdMec(opcion: 1),
      const FormularioCrearAdMec(opcion: 2)
    ];

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "GESTIÓN DE TRABAJADORES",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                  icon: Icon(Icons.add_moderator_outlined,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Nuevo Admin'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_crash_outlined,
                      color: Color.fromRGBO(237, 242, 244, 1)),
                  label: 'Nuevo Mecánico')
            ],
            currentIndex: indices,
            onTap: (int index) {
              setState(() {
                indices = index;
              });
            }));
  }
}
