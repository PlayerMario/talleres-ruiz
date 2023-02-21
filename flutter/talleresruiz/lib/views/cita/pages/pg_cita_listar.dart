import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class CitaListarPage extends StatefulWidget {
  const CitaListarPage({Key? key}) : super(key: key);

  @override
  State<CitaListarPage> createState() => _CitaListarPage();
}

class _CitaListarPage extends State<CitaListarPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListasCitaBloc, ListasCitaState>(
        builder: (context, state) {
      switch (state.status) {
        case ListasCitaStatus.failure:
          if (state.error.subErrors != null) {
            return ListView.builder(
                itemCount: state.error.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.error.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.error);
          }
        case ListasCitaStatus.success:
          if (state.response.isEmpty) {
            return ErrorScreen(error: state.error);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.response.length
                    ? const BottomLoader()
                    : CitaListItem(cita: state.response[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.response.length
                  : state.response.length + 1,
              controller: scrollController,
            );
          }
        case ListasCitaStatus.initial:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    super.dispose();
  }

  void onScroll() {
    if (_isBottom && !context.read<ListasCitaBloc>().state.hasReachedMax) {
      context.read<ListasCitaBloc>().add(EventListaCitas());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }
}
