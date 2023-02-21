import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talleresruiz/main.dart';

class ClienteCitasPage extends StatefulWidget {
  const ClienteCitasPage({super.key, required this.rol});
  final String rol;

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
    return BlocBuilder<ListasCitaClienteBloc, ListasCitaClienteState>(
        builder: (context, state) {
      switch (state.status) {
        case ListasCitaClienteStatus.failure:
          if (state.error.subErrors != null) {
            return ListView.builder(
                itemCount: state.error.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.error.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.error);
          }
        case ListasCitaClienteStatus.success:
          if (state.response.isEmpty) {
            return ErrorScreen(error: state.error);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.response.length
                    ? const BottomLoader()
                    : CitaClienteListItem(
                        cita: state.response[index], rol: widget.rol);
              },
              itemCount: state.hasReachedMax
                  ? state.response.length
                  : state.response.length + 1,
              controller: scrollController,
            );
          }
        case ListasCitaClienteStatus.initial:
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
    if (_isBottom)
      context.read<ListasCitaClienteBloc>().add(EventListaCitasCliente());
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }
}
