import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class ClienteListarPage extends StatefulWidget {
  const ClienteListarPage({super.key, required this.rol});
  final String rol;

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
    return BlocBuilder<ListasClienteBloc, ListasClienteState>(
        builder: (context, state) {
      switch (state.status) {
        case ListasClienteStatus.failure:
          return Center(
              child: Card(
                  color: const Color.fromRGBO(43, 45, 66, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  shadowColor: const Color.fromRGBO(43, 45, 66, 1),
                  margin: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 40),
                  elevation: 5,
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const SizedBox(
                          child: Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                "No existen clientes",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color.fromRGBO(237, 242, 244, 1)),
                                textAlign: TextAlign.center,
                              ))))));
        case ListasClienteStatus.success:
          if (state.response.isEmpty) {
            return ErrorScreen(error: state.error);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.response.length
                    ? const BottomLoader()
                    : ClienteListItem(
                        cliente: state.response[index], rol: widget.rol);
              },
              itemCount: state.hasReachedMax
                  ? state.response.length
                  : state.response.length + 1,
              controller: scrollController,
            );
          }
        case ListasClienteStatus.initial:
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
    if (_isBottom && !context.read<ListasClienteBloc>().state.hasReachedMax) {
      context.read<ListasClienteBloc>().add(EventListaClientes());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }
}
