import 'dart:convert';
import '../../../main.dart';
import 'package:flutter/material.dart';

class FormularioEditarAdMec extends StatefulWidget {
  const FormularioEditarAdMec({super.key, required this.mecanico, required this.id});
  final MecanicoMeResponse mecanico;
  final String id;

  @override
  State<FormularioEditarAdMec> createState() => _FormularioEditarAdMec();
}

class _FormularioEditarAdMec extends State<FormularioEditarAdMec> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nombre = TextEditingController(
        text: utf8.decode(widget.mecanico.nombre!.codeUnits));
    final email = TextEditingController(
        text: utf8.decode(widget.mecanico.email!.codeUnits));
    final tlf = TextEditingController(
        text: utf8.decode(widget.mecanico.tlf!.codeUnits));

    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "MODIFICAR USUARIO",
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
        body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
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
                            controller: nombre,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Nombre',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca el nombre completo',
                                suffixIcon: Icon(
                                  Icons.perm_identity_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
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
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca el email',
                                suffixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
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
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Teléfono',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca el número de teléfono',
                                suffixIcon: Icon(
                                  Icons.phone_enabled_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El teléfono es obligatorio';
                              }
                              return null;
                            },
                          ),
                        )),
                    Container(
                      height: 45,
                      width: 120,
                      margin: const EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(43, 45, 66, 1))),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AdMecEditarBody adMec = AdMecEditarBody(
                                nombre: nombre.text,
                                email: email.text,
                                tlf: tlf.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderAdMecEditar(
                                  adMec: adMec, id: widget.id);
                            }));
                          }
                        },
                        child: const Text(
                          'Modificar',
                          style: TextStyle(color: Color.fromRGBO(237, 242, 244, 1), fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
