import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import '../../../main.dart';
import 'dart:convert';
import 'package:select_form_field/select_form_field.dart';

class CitaEditarAdMec extends StatefulWidget {
  const CitaEditarAdMec({super.key, required this.cita, required this.rol});
  final CitaDetallesResponse cita;
  final String rol;

  @override
  State<CitaEditarAdMec> createState() => _CitaEditarAdMec();
}

class _CitaEditarAdMec extends State<CitaEditarAdMec> {
  late DateTime fechaHora;
  String estado = "";

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Aceptada',
      'label': 'Aceptada',
    },
    {
      'value': 'Proceso',
      'label': 'Proceso',
    },
    {
      'value': 'Terminada',
      'label': 'Terminada',
    },
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String fechaCita = widget.cita.fechaHora!;
    DateTime fecha = convertirFecha(fechaCita);
    fechaHora = fecha;
    //print(fecha);

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
                            initialValue: fecha,
                            initialDate: fecha,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.always,
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
                            child: SelectFormField(
                              type: SelectFormFieldType.dropdown,
                              initialValue:
                                  utf8.decode(widget.cita.estado!.codeUnits),
                              labelText: 'Estado',
                              items: _items,
                              onChanged: (val) {
                                estado = val;
                                print(estado);
                              },
                              /*onSaved: (val) {
                                estado = val!;
                                print(estado);
                              },*/
                            ))),
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
                            CitaEditarAdMecBody cita = CitaEditarAdMecBody(
                                fechaHora: fechaHora.toIso8601String(),
                                estado: estado);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderEditarCitaAdMec(
                                  cita: cita,
                                  id: widget.cita.id!,
                                  rol: widget.rol);
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
