import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../main.dart';

class MecanicoListarPage extends StatefulWidget {
  const MecanicoListarPage({super.key, required this.rol});
  final String rol;

  @override
  State<MecanicoListarPage> createState() => _MecanicoListarPage();
}

class _MecanicoListarPage extends State<MecanicoListarPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListasMecanicoBloc, ListasMecanicoState>(
        builder: (context, state) {
      switch (state.status) {
        case ListasMecanicoStatus.failure:
          if (state.error.subErrors != null) {
            return ListView.builder(
                itemCount: state.error.subErrors!.length,
                itemBuilder: (BuildContext context, int index) {
                  return SubErrorData(error: state.error.subErrors![index]);
                });
          } else {
            return ErrorScreenAppBar(error: state.error);
          }
        case ListasMecanicoStatus.success:
          if (state.response.isEmpty) {
            return ErrorScreen(error: state.error);
          } else {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.response.length
                    ? const BottomLoader()
                    : MecanicoListItem(
                        mecanico: state.response[index], rol: widget.rol);
              },
              itemCount: state.hasReachedMax
                  ? state.response.length
                  : state.response.length + 1,
              controller: scrollController,
            );
          }
        case ListasMecanicoStatus.initial:
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
    if (_isBottom && !context.read<ListasMecanicoBloc>().state.hasReachedMax) {
      context.read<ListasMecanicoBloc>().add(EventListaMecanicos());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.85);
  }
}
