import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLoginBloc, UserLoginState>(builder: (context, state) {
      switch (state.status) {
        case UserLoginStatus.failure:
          if (state.userLogin.subErrors != null) {
            return ListView.builder(
                itemCount: state.userLogin.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.userLogin.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.userLogin);
          }
        case UserLoginStatus.success:
          if (state.userLogin.roles[0] == "CLIENTE") {
            print("Login Cliene");
            return ProviderClienteHome();
          } else {
            print("Login Admin-Mec");
          }

          return Center(child: Text("Logueado ${state.userLogin}"));
        case UserLoginStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
