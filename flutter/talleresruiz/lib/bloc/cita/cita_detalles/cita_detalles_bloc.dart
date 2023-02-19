import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part './cita_detalles_event.dart';
part './cita_detalles_state.dart';

class CitaDetallesBloc extends Bloc<CitaDetallesEvent, CitaDetallesState> {
  final CitaServiceAbs _citaService;

  CitaDetallesBloc({required int id, required CitaServiceAbs citaService})
      : assert(citaService != null),
        _citaService = citaService,
        super(const CitaDetallesState()) {
    on<CitaDetallesFetched>(onCitaDetalles);
  }

  Future<void> onCitaDetalles(
      CitaDetallesFetched event, Emitter<CitaDetallesState> emit) async {
    if (state.status == CitaDetallesStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final citaDetalles = await _citaService.getDetallesCita(event.id);

      if (citaDetalles[1]) {
        return emit(state.copyWith(
            status: CitaDetallesStatus.success, citaDetalles: citaDetalles[0]));
      } else {
        return emit(state.copyWith(
            status: CitaDetallesStatus.failure, citaDetalles: citaDetalles[0]));
      }
    }
  }
}
