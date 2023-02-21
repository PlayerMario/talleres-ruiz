import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class AdMecCrearPage extends StatefulWidget {
  const AdMecCrearPage({Key? key}) : super(key: key);

  @override
  State<AdMecCrearPage> createState() => _AdMecCrearPage();
}

class _AdMecCrearPage extends State<AdMecCrearPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdMecBloc, AdMecState>(builder: (context, state) {
      switch (state.status) {
        case AdMecStatus.failure:
          if (state.response.subErrors! != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case AdMecStatus.success:
          return DetallesNuevoAdMec(adMec: state.response);
        case AdMecStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
