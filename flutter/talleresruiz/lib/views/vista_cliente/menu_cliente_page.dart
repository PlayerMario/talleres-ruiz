import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';

class MenuClientePage extends StatefulWidget {
  const MenuClientePage({Key? key}) : super(key: key);

  @override
  State<MenuClientePage> createState() => _MenuClientePage();
}

class _MenuClientePage extends State<MenuClientePage> {
  @override
  void initState() {
    super.initState();
  }

  /*
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
          if (state.userLogin.roles[0] == "CLIENTE") {
            print("Login Cliene");
            return VistaClientePage();
          } else {
            print("Login Admin-Mec");
          }

          return Center(child: Text("Logueado ${state.userLogin}"));
        case LoginStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
  */
}