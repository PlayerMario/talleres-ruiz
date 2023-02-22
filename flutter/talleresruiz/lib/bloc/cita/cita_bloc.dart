import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part 'cita_state.dart';
part 'cita_event.dart';

class CitaBloc extends Bloc<CitaEvent, CitaState> {
  final CitaServiceAbs _citaService;

  CitaBloc({required CitaServiceAbs citaService})
      : assert(citaService != null),
        _citaService = citaService,
        super(const CitaState()) {
    on<EventCitaDetalles>(onCitaDetalles);
    on<EventCrearCitaCliente>(onCitaCrearCliente);
    on<EventCrearCitaAdMec>(onCitaCrearAdMec);
    on<EventEditarCitaCliente>(onCitaEditarCliente);
    on<EventEditarCitaAdMec>(onCitaEditarAdMec);
    on<EventBorrarCitaCliente>(onCitaBorrarCliente);
  }

  Future<void> onCitaDetalles(
      EventCitaDetalles event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final citaDetalles = await _citaService.getDetallesCita(event.id);

      if (citaDetalles[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: citaDetalles[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: citaDetalles[0]));
      }
    }
  }

  Future<void> onCitaCrearCliente(
      EventCrearCitaCliente event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      final citaClienteCreada =
          await _citaService.postCrearCitaCliente(event.cita);

      if (citaClienteCreada[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: citaClienteCreada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: citaClienteCreada[0]));
      }
    }
  }

  Future<void> onCitaCrearAdMec(
      EventCrearCitaAdMec event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      final citaClienteCreada =
          await _citaService.postCrearCitaAdMec(event.cita);

      if (citaClienteCreada[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: citaClienteCreada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: citaClienteCreada[0]));
      }
    }
  }

  Future<void> onCitaEditarCliente(
      EventEditarCitaCliente event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      final citaClienteEditada =
          await _citaService.putCitaCliente(event.id, event.cita);

      if (citaClienteEditada[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: citaClienteEditada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: citaClienteEditada[0]));
      }
    }
  }

  Future<void> onCitaEditarAdMec(
      EventEditarCitaAdMec event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      final citaAdMecEditada =
          await _citaService.putCitaAdMec(event.id, event.cita);

      if (citaAdMecEditada[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: citaAdMecEditada[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: citaAdMecEditada[0]));
      }
    }
  }

  Future<void> onCitaBorrarCliente(
      EventBorrarCitaCliente event, Emitter<CitaState> emit) async {
    await _citaService.delCitaCliente(event.id);
    emit(const CitaState());
  }
}
