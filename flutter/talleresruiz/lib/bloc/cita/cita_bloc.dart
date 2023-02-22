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
    on<EventBorrarCitaAdMec>(onCitaBorrarAdMec);
    on<EventAgregarMsj>(onCitaAgregarMsj);
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
      await Future.delayed(const Duration(milliseconds: 500));
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
      await Future.delayed(const Duration(milliseconds: 500));
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
      await Future.delayed(const Duration(milliseconds: 500));
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
      await Future.delayed(const Duration(milliseconds: 500));
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
    await Future.delayed(const Duration(milliseconds: 500));
    await _citaService.delCitaCliente(event.id);
    emit(const CitaState());
  }

  Future<void> onCitaBorrarAdMec(
      EventBorrarCitaAdMec event, Emitter<CitaState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _citaService.delCitaAdMec(event.id);
    emit(const CitaState());
  }

  Future<void> onCitaAgregarMsj(
      EventAgregarMsj event, Emitter<CitaState> emit) async {
    if (state.status == CitaStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final adjuntoMsj = await _citaService.agregarMsj(event.adjunto, event.id);

      if (adjuntoMsj[1]) {
        return emit(state.copyWith(
            status: CitaStatus.success, response: adjuntoMsj[0]));
      } else {
        return emit(state.copyWith(
            status: CitaStatus.failure, response: adjuntoMsj[0]));
      }
    }
  }
}
