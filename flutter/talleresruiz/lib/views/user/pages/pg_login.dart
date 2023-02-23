import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

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
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      switch (state.status) {
        case UserStatus.failure:
          if (state.response.subErrors != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case UserStatus.success:
          if (state.response.roles[0] == "CLIENTE") {
            print("Login Cliene");
            return const ProviderClienteHome();
          } else {
            print("Login Admin-Mec");
            return const ProviderAdMecHome();
          }
        case UserStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
