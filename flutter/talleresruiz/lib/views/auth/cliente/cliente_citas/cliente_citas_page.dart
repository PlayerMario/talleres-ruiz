import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/main.dart';

class ClienteCitasPage extends StatefulWidget {
  const ClienteCitasPage({Key? key}) : super(key: key);

  @override
  State<ClienteCitasPage> createState() => _ClienteCitasPage();
}

class _ClienteCitasPage extends State<ClienteCitasPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteCitasBloc, ClienteCitasState>(
        builder: (context, state) {
      switch (state.status) {
        case ClienteCitasStatus.failure:
          if (state.clienteCitas.subErrors != null) {
            return ListView.builder(
                itemCount: state.clienteCitas.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(
                      error: state.clienteCitas.subErrors![index]);
                });
          } else {
            return ErrorScreen(error: state.clienteCitas);
          }
        case ClienteCitasStatus.success:
          if (state.clienteCitas.content.isEmpty) {
            return ErrorScreen(error: state.clienteCitas);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.clienteCitas.content.length
                    ? const BottomLoader()
                    : CitaListItem(cita: state.clienteCitas.content[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.clienteCitas.content.length
                  : state.clienteCitas.content.length + 1,
              controller: scrollController,
            );
          }
        case ClienteCitasStatus.initial:
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
    if (_isBottom) context.read<ClienteCitasBloc>().add(ClienteCitasFetched());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.80);
  }
}
