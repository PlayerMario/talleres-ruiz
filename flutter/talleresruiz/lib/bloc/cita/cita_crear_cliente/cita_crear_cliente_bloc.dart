import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../../main.dart';

part 'cita_crear_cliente_event.dart';
part 'cita_crear_cliente_state.dart';

class CitaCrearClienteBloc
    extends Bloc<CitaCrearClienteEvent, CitaCrearClienteState> {
  final CitaServiceAbs _citaService;

  CitaCrearClienteBloc(
      {required CitaCrearClienteBody citaCliente,
      required CitaServiceAbs citaService})
      : assert(citaCliente != null),
        _citaService = citaService,
        super(const CitaCrearClienteState()) {
    on<CitaCrearClienteFetched>(onCitaCrearCliente);
    on<CitaEditarClienteFetched>(onCitaEditarCliente);
  }

  Future<void> onCitaCrearCliente(CitaCrearClienteFetched event,
      Emitter<CitaCrearClienteState> emit) async {
    if (state.status == CitaCrearClienteStatus.initial) {
      final citaClienteCreada =
          await _citaService.postCrearCitaCliente(event.cita);

      if (citaClienteCreada[1]) {
        return emit(state.copyWith(
            status: CitaCrearClienteStatus.success,
            citaClienteCreada: citaClienteCreada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaCrearClienteStatus.failure,
            citaClienteCreada: citaClienteCreada[0]));
      }
    }
  }

  Future<void> onCitaEditarCliente(CitaEditarClienteFetched event,
      Emitter<CitaCrearClienteState> emit) async {
    if (state.status == CitaCrearClienteStatus.initial) {
      final citaClienteEditada =
          await _citaService.putCitaCliente(event.id, event.cita);

      if (citaClienteEditada[1]) {
        return emit(state.copyWith(
            status: CitaCrearClienteStatus.success,
            citaClienteCreada: citaClienteEditada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaCrearClienteStatus.failure,
            citaClienteCreada: citaClienteEditada[0]));
      }
    }
  }
}
