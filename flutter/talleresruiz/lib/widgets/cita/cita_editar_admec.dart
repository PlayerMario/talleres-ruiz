import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
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
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Fecha y hora',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText:
                                    'Introduzca la fecha y hora de la cita',
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
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
                              });
                            },
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(15),
                        child: SizedBox(
                            width: 350,
                            child: SelectFormField(
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(43, 45, 66, 1),
                                          width: 1)),
                                  border: UnderlineInputBorder(),
                                  labelText: 'Estado',
                                  labelStyle: TextStyle(
                                      color: Color.fromRGBO(43, 45, 66, 1)),
                                  hintText: 'Introduzca el estado de la cita',
                                  suffixIcon: Icon(
                                    Icons.check_box_outlined,
                                    color: Color.fromRGBO(43, 45, 66, 1),
                                    size: 25,
                                  )),
                              type: SelectFormFieldType.dropdown,
                              initialValue:
                                  utf8.decode(widget.cita.estado!.codeUnits),
                              labelText: 'Estado',
                              items: _items,
                              onChanged: (val) {
                                estado = val;
                              },
                            ))),
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
                          style: TextStyle(
                              color: Color.fromRGBO(237, 242, 244, 1),
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
