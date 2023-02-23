import 'package:flutter/material.dart';
import '../../main.dart';

class FormularioEditarPswd extends StatefulWidget {
  const FormularioEditarPswd({super.key, required this.rol});
  final String rol;

  @override
  State<FormularioEditarPswd> createState() => _FormularioEditarPswd();
}

class _FormularioEditarPswd extends State<FormularioEditarPswd> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final verifyNewPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(237, 242, 244, 1),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "CAMBIAR CONTRASEÑA",
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
                            controller: oldPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Antigua Contraseña',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca la antigua contraseña',
                                suffixIcon: Icon(
                                  Icons.password_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La antigua contraseña es obligatoria';
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
                            controller: newPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Nueva Contraseña',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Introduzca la nueva contraseña',
                                suffixIcon: Icon(
                                  Icons.password_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
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
                            controller: verifyNewPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromRGBO(43, 45, 66, 1),
                                        width: 1)),
                                border: UnderlineInputBorder(),
                                labelText: 'Verificar Nueva Contraseña',
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(43, 45, 66, 1)),
                                hintText: 'Repita la nueva contraseña',
                                suffixIcon: Icon(
                                  Icons.password_outlined,
                                  color: Color.fromRGBO(43, 45, 66, 1),
                                  size: 25,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Debe verificar su contraseña';
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
                            UserEditarPswdBody newPswd = UserEditarPswdBody(
                                oldPassword: oldPassword.text,
                                newPassword: newPassword.text,
                                verifyNewPassword: verifyNewPassword.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderUserEditarPswd(
                                pswd: newPswd,
                                rol: widget.rol,
                              );
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
