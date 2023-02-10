import 'package:flutter/material.dart';
import '../crear_cliente.dart';
export './crear_cliente_screen.dart';

class CrearClienteScreen extends StatelessWidget {
  CrearClienteScreen({super.key});
  final username = TextEditingController();
  final password = TextEditingController();
  final passwordVerify = TextEditingController();
  final dni = TextEditingController();
  final nombre = TextEditingController();
  final email = TextEditingController();
  final tlf = TextEditingController();
  final vehiculo = TextEditingController();
  final matricula = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Crear usuarios"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Usuario',
                    hintText: 'Introduzca su nombre de usuario'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Introduzca su contraseña'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordVerify,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Repita su contraseña'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: dni,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'DNI',
                    hintText: 'Introduzca su DNI (11111111A)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: nombre,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Introduzca su nombre completo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Introduzca su email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: tlf,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Teléfono',
                    hintText: 'Introduzca su teléfono (111 222 333)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: vehiculo,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehículo',
                    hintText: 'Introduzca la marca y modelo de su vehículo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: matricula,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Matrícula',
                    hintText:
                        'Introduzca la matrícula de su vehículo (1111AAA)'),
              ),
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(50)),
              child: ElevatedButton(
                onPressed: () {
                  // HACERLO CON EL BLOC PARA QUE MUESTRE UNA PANTALLA CON LOS DATOS RECIÉN CREADOS
                  buscarClienteCreado(
                      username.text,
                      password.text,
                      passwordVerify.text,
                      dni.text,
                      nombre.text,
                      email.text,
                      tlf.text,
                      vehiculo.text,
                      matricula.text);
                  Navigator.pop(context);
                },
                child: const Text(
                  'Crear',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
