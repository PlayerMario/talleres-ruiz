import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/main.dart';

class AdMecHomePage extends StatefulWidget {
  const AdMecHomePage({Key? key}) : super(key: key);

  @override
  State<AdMecHomePage> createState() => _AdMecHomePage();
}

class _AdMecHomePage extends State<AdMecHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdMecBloc, AdMecState>(builder: (context, state) {
      switch (state.status) {
        case AdMecStatus.failure:
          if (state.response.subErrors != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case AdMecStatus.success:
          return AdMecMenu(mecanicoMe: state.response);
        case AdMecStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
