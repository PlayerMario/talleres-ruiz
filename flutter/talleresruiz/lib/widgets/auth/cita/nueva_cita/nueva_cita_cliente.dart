import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../main.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/date_symbol_data_local.dart';

class NuevaCitaCliente extends StatefulWidget {
  const NuevaCitaCliente({super.key});
  @override
  State<NuevaCitaCliente> createState() => _NuevaCitaCliente();
}

class _NuevaCitaCliente extends State<NuevaCitaCliente> {
  late DateTime fechaHora;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //DateTime fechaHora;
    //initializeDateFormatting('es');
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
                            CitaCrearClienteBody cita = CitaCrearClienteBody(
                                fechaHora: fechaHora.toIso8601String());
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderNuevaCitaCliente(cita: cita);
                            }));
                          }
                        },
                        child: const Text(
                          'Pedir cita',
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
