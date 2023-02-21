import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class ClienteListarPage extends StatefulWidget {
  const ClienteListarPage({Key? key}) : super(key: key);

  @override
  State<ClienteListarPage> createState() => _ClienteListarPage();
}

class _ClienteListarPage extends State<ClienteListarPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClienteBloc, ClienteState>(builder: (context, state) {
      switch (state.status) {
        case ClienteStatus.failure:
          if (state.response.subErrors != null) {
            return ListView.builder(
                itemCount: state.response.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.response.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.response);
          }
        case ClienteStatus.success:
          if (state.response.isEmpty) {
            return ErrorScreen(error: state.response);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.response.length
                    ? const BottomLoader()
                    : ClienteListItem(cliente: state.response[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.response.length
                  : state.response.length + 1,
              controller: scrollController,
            );
          }
        case ClienteStatus.initial:
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
    if (_isBottom) context.read<ClienteBloc>().add(EventCitasCliente());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.80);
  }
}
