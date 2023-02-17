import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class UsuarioLogScreen extends StatefulWidget {
  const UsuarioLogScreen({Key? key}) : super(key: key);

  @override
  State<UsuarioLogScreen> createState() => MenuPrincipal();
}

class MenuPrincipal extends State<UsuarioLogScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      switch (state.status) {
        case LoginStatus.failure:
          if (state.userLogin.subErrors != null) {
            return ListView.builder(
                itemCount: state.userLogin.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.userLogin.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.userLogin);
          }
        case LoginStatus.success:
          // A la pantalla de /me cliente, si es cliente a la suya, si es admin a otra
          // HACE UNA LLAMADA A UN NUEVO BLOC QUE LLEVE A LA PANTALLA
          print("Login Correcto");
          return Center(child: Text("Logueado ${state.userLogin}"));
        case LoginStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
