import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class GlobalContext {  
  static late BuildContext ctx;
}

/*class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginForm();
}*/

class FormularioLogin extends /*State<LoginForm>*/ StatelessWidget {
  static late FormularioLogin _instance;
  final username = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static Route route() {
    print("Enrutando al login");
    return MaterialPageRoute<void>(builder: (context) {
      var authBloc = BlocProvider.of<UserLoginBloc>(context);
      authBloc.add(UserSessionExpired());
      return _instance;
    });
  }

  FormularioLogin() {
    _instance = this;
  }

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
                            controller: username,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Usuario',
                                hintText: 'Introduzca su nombre de usuario'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'El nombre de usuario es obligatorio';
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
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Contraseña',
                                hintText: 'Introduzca su contraseña'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'La contraseña es obligatoria';
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
                            UserLoginBody login = UserLoginBody(username: username.text, password: password.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderLogin(login: login);
                            }));
                          }
                        },
                        child: const Text(
                          'Iniciar Sesión',
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