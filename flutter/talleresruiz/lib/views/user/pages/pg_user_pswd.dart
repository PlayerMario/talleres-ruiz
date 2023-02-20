import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class UserEditarPswdPage extends StatefulWidget {
  const UserEditarPswdPage({Key? key}) : super(key: key);

  @override
  State<UserEditarPswdPage> createState() => _UserEditarPswdPage();
}

class _UserEditarPswdPage extends State<UserEditarPswdPage> {
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
          return const ProviderClienteHome();
        case UserStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
