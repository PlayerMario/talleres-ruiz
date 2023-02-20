import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import '../../../main.dart';
import 'dart:convert';

class CitaEditarCliente extends StatefulWidget {
  const CitaEditarCliente({super.key, required this.cita});
  final CitaDetallesResponse cita;

  @override
  State<CitaEditarCliente> createState() => _CitaEditarCliente();
}

class _CitaEditarCliente extends State<CitaEditarCliente> {
  final _formKey = GlobalKey<FormState>();
  late DateTime fechaHora;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "MODIFICAR CITA",
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
                            readOnly: true,
                            initialValue: widget.cita.mecanico != null
                                ? utf8.decode(widget.cita.mecanico!.codeUnits)
                                : "Sin asignar",
                            /*keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Nombre',
                                hintText: 'Introduzca su nombre completo'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nombre del usuario es obligatorio';
                              }
                              return null;
                            },*/
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                              readOnly: true,
                              initialValue:
                                  utf8.decode(widget.cita.cliente!.codeUnits)
                              /*keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                                hintText: 'Introduzca su email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El email es obligatorio';
                              }
                              return null;
                            },*/
                              ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            readOnly: true,
                            initialValue:
                                utf8.decode(widget.cita.vehiculo!.codeUnits),
                            /*keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Teléfono',
                                hintText: 'Introduzca su teléfono'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El teléfono es obligatorio';
                              }
                              return null;
                            },*/
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Fecha y hora',
                            ),
                            use24hFormat: true,
                            initialDatePickerMode: DatePickerMode.day,
                            initialDate: DateTime.now(),
                            //dateFormat: DateFormat("dd-MM-yyyy HH:mm", 'es'),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
                            /*validator: (value) {
                              if (value!.toIso8601String().isEmpty) {
                                return 'La fecha y hora es obligatoria';
                              }
                              return null;
                            },*/
                            onDateSelected: (value) {
                              setState(() {                                
                                fechaHora = value;
                                print(fechaHora);
                              });
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            readOnly: true,
                            initialValue:
                                utf8.decode(widget.cita.estado!.codeUnits),
                            /*keyboardType: TextInputType.text,
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
                            },*/
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
                            /*ClienteEditarBody cliente = ClienteEditarBody(
                                nombre: nombre.text,
                                email: email.text,
                                tlf: tlf.text,
                                vehiculo: vehiculo.text,
                                matricula: matricula.text);*/
                                CitaCrearClienteBody cita = CitaCrearClienteBody(
                                fechaHora: fechaHora.toIso8601String());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderEditarCitaCliente(cita: cita, id: widget.cita.id!);
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
