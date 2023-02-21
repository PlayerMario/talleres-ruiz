import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:date_field/date_field.dart';

class CitaNuevaAdMec extends StatefulWidget {
  const CitaNuevaAdMec({super.key, required this.rol});
  final String rol;

  @override
  State<CitaNuevaAdMec> createState() => _CitaNuevaAdMec();
}

class _CitaNuevaAdMec extends State<CitaNuevaAdMec> {
  late DateTime fechaHora;
  final dni = TextEditingController();

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
                            controller: dni,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'DNI cliente',
                                hintText: 'Introduzca el DNI del cliente'),
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
                            CitaCrearAdMecBody cita = CitaCrearAdMecBody(
                                dni: dni.text,
                                fechaHora: fechaHora.toIso8601String());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderNuevaCitaAdMec(
                                  cita: cita, rol: widget.rol);
                            }));
                          }
                        },
                        child: const Text(
                          'Generar cita',
                          style: TextStyle(
                              color: Color.fromRGBO(237, 242, 244, 1),
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
