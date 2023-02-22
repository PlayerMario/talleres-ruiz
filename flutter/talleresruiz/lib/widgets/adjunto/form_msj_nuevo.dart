import 'package:flutter/material.dart';
import '../../main.dart';

class FormularioNuevoMensaje extends StatefulWidget {
  const FormularioNuevoMensaje(
      {super.key, required this.id, required this.rol});
  final int id;
  final String rol;

  @override
  State<FormularioNuevoMensaje> createState() => _FormularioNuevoMensaje();
}

class _FormularioNuevoMensaje extends State<FormularioNuevoMensaje> {
  final contenido = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "NUEVO MENSAJE",
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
                            controller: contenido,
                            keyboardType: TextInputType.name,
                            maxLines: 6,
                            minLines: 1,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Mensaje',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca el mensaje',
                                suffixIcon: Icon(
                                  Icons.message_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El mensaje es obligatorio';
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
                            AdjuntoMsjBody adjunto =
                                AdjuntoMsjBody(contenido: contenido.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderMsjAdjuntoCrear(
                                  adjunto: adjunto,
                                  id: widget.id,
                                  rol: widget.rol);
                            }));
                          }
                        },
                        child: const Text(
                          'Enviar',
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
