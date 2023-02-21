import 'package:flutter/material.dart';
import '../../main.dart';

class FormularioCrearAdMec extends StatefulWidget {
  const FormularioCrearAdMec({super.key, required this.opcion});
  final int opcion;

  @override
  State<FormularioCrearAdMec> createState() => _FormularioCrearAdMec();
}

class _FormularioCrearAdMec extends State<FormularioCrearAdMec> {
  final username = TextEditingController();
  final password = TextEditingController();
  final passwordVerify = TextEditingController();
  final dni = TextEditingController();
  final nombre = TextEditingController();
  final email = TextEditingController();
  final tlf = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 30.0),
                      child: Center(
                        child: SizedBox(
                            width: 200,
                            height: 150,
                            child: Image.asset('assets/images/logo.png')),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: username,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Usuario',
                                hintText: 'Introduzca el nombre de usuario'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nombre de usuario es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contraseña',
                                hintText: 'Introduzca la contraseña'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La contraseña es obligatoria';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: passwordVerify,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Verificar Contraseña',
                                hintText: 'Repita la contraseña'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Debe verificar su contraseña';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: dni,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'DNI',
                                hintText: 'Introduzca el DNI'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El DNI es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: nombre,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nombre',
                                hintText: 'Introduzca el nombre completo'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nombre del usuario es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Introduzca el email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El email es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            controller: tlf,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Teléfono',
                                hintText: 'Introduzca el teléfono'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El teléfono es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(43, 45, 66, 1))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AdMecCrearBody adMec = AdMecCrearBody(
                                username: username.text,
                                password: password.text,
                                verifyPassword: passwordVerify.text,
                                dni: dni.text,
                                nombre: nombre.text,
                                email: email.text,
                                tlf: tlf.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderAdMecCrear(
                                  adMec: adMec, opcion: widget.opcion);
                            }));
                          }
                        },
                        child: const Text(
                          'Crear',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
