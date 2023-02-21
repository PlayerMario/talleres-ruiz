import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:get_it/get_it.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../main.dart';

part 'admec_event.dart';
part 'admec_state.dart';

class AdMecBloc extends Bloc<AdMecEvent, AdMecState> {
  final AdMecServiceAbs _adMecService;

  AdMecBloc({required AdMecServiceAbs adMecService})
      : assert(adMecService != null),
        _adMecService = adMecService,
        super(const AdMecState()) {
    on<EventAdMecHome>(onMostrarAdMecMe);
    on<EventLogoutAdMec>(onLogoutAdMec);
  }

  Future<void> onMostrarAdMecMe(
      EventAdMecHome event, Emitter<AdMecState> emit) async {
    if (state.status == AdMecStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final adMecMe = await _adMecService.getAdMecLogin();

      if (adMecMe[1]) {
        return emit(
            state.copyWith(response: adMecMe[0], status: AdMecStatus.success));
      } else {
        return emit(
            state.copyWith(response: adMecMe[0], status: AdMecStatus.failure));
      }
    }
  }

  Future<void> onLogoutAdMec(
      EventLogoutAdMec event, Emitter<AdMecState> emit) async {
    await _adMecService.adMecLogout();
    emit(const AdMecState());
  }
}
