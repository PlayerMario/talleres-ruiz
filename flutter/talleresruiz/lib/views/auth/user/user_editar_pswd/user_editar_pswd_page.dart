import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main.dart';

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
    return BlocBuilder<UserEditarPswdBloc, UserEditarPswdState>(
        builder: (context, state) {
      switch (state.status) {
        case UserEditarPswdStatus.failure:
          if (state.pswd.subErrors != null) {
            return ListView.builder(
                itemCount: state.pswd.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.pswd.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.pswd);
          }
        case UserEditarPswdStatus.success:
          return const ProviderClienteHome();
        case UserEditarPswdStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
