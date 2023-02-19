import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

part './cliente_citas_event.dart';
part './cliente_citas_state.dart';

const throttleDuration = Duration(milliseconds: 1000);
int newPage = 0;

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ClienteCitasBloc extends Bloc<ClienteCitasEvent, ClienteCitasState> {
  final ClienteServiceAbs _clienteService;

  ClienteCitasBloc({required ClienteServiceAbs clienteService})
      : assert(clienteService != null),
        _clienteService = clienteService,
        super(const ClienteCitasState()) {
    on<ClienteCitasFetched>(onClienteCitas,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> onClienteCitas(
      ClienteCitasFetched event, Emitter<ClienteCitasState> emit) async {
    if (state.hasReachedMax) return;

    if (state.status == ClienteCitasStatus.initial) {
      newPage += 1;

      await Future.delayed(const Duration(milliseconds: 500));

      final clienteCitas = await _clienteService.getClienteCitas(newPage);

      if (clienteCitas[1]) {
        return emit(state.copyWith(
            status: ClienteCitasStatus.success,
            clienteCitas: clienteCitas[0],
            hasReachedMax: false));
      } else {
        return emit(state.copyWith(
            status: ClienteCitasStatus.failure, clienteCitas: clienteCitas[0]));
      }
    }

    await Future.delayed(const Duration(milliseconds: 500));

    final clienteCitas = await _clienteService.getClienteCitas(newPage);
    clienteCitas.content!.isEmpty
        ? emit(state.copyWith(hasReachedMax: true))
        : emit(state.copyWith(
            status: ClienteCitasStatus.success,
            clienteCitas: List.of(state.clienteCitas)
              ..addAll(clienteCitas.content!),
            hasReachedMax: false));
  }
}
