import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:date_field/date_field.dart';

class CitaNuevaCliente extends StatefulWidget {
  const CitaNuevaCliente({super.key, required this.rol});
  final String rol;

  @override
  State<CitaNuevaCliente> createState() => _CitaNuevaCliente();
}

class _CitaNuevaCliente extends State<CitaNuevaCliente> {
  late DateTime fechaHora;

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
                            initialDate: DateTime.now(),
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
                            CitaCrearClienteBody cita = CitaCrearClienteBody(
                                fechaHora: fechaHora.toIso8601String());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderNuevaCitaCliente(
                                  cita: cita, rol: widget.rol);
                            }));
                          }
                        },
                        child: const Text(
                          'Pedir cita',
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
