import 'dart:convert';
import '../../../main.dart';
import 'package:flutter/material.dart';

class FormularioEditarCliente extends StatefulWidget {
  const FormularioEditarCliente({super.key, required this.cliente});
  final ClienteMeResponse cliente;

  @override
  State<FormularioEditarCliente> createState() => _FormularioEditarCliente();
}

class _FormularioEditarCliente extends State<FormularioEditarCliente> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final nombre = TextEditingController(
        text: utf8.decode(widget.cliente.nombre!.codeUnits));
    final email = TextEditingController(
        text: utf8.decode(widget.cliente.email!.codeUnits));
    final tlf =
        TextEditingController(text: utf8.decode(widget.cliente.tlf!.codeUnits));
    final vehiculo = TextEditingController(
        text: utf8.decode(widget.cliente.vehiculo!.split('-')[1].codeUnits));
    final matricula = TextEditingController(
        text: utf8.decode(widget.cliente.vehiculo!.split('-')[0].codeUnits));

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
                            controller: nombre,
                            //initialValue: widget.cliente.nombre!,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nombre',
                                hintText: 'Introduzca su nombre completo'),
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
                            //initialValue: widget.cliente.email!,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Introduzca su email'),
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
                            //initialValue: widget.cliente.tlf!,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Teléfono',
                                hintText: 'Introduzca su teléfono'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El teléfono es obligatorio';
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
                            controller: vehiculo,
                            //initialValue: widget.cliente.vehiculo!.split('-')[0],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Vehículo',
                                hintText:
                                    'Introduzca la marca y modelo de su vehículo'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Los datos del vehículo son obligatorios';
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
                            controller: matricula,
                            //initialValue: widget.cliente.vehiculo!.split('-')[1],
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Matrícula',
                                hintText:
                                    'Introduzca la matrícula de su vehículo'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La matrícula del vehículo es obligatoria';
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
                            ClienteEditarBody cliente = ClienteEditarBody(
                                nombre: nombre.text,
                                email: email.text,
                                tlf: tlf.text,
                                vehiculo: vehiculo.text,
                                matricula: matricula.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderClienteEditar(cliente: cliente);
                            }));
                          }
                        },
                        child: const Text(
                          'Modificar',
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
