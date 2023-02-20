import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part './user_event.dart';
part './user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserServiceAbs _userService;

  UserBloc({required UserServiceAbs userService})
      : assert(userService != null),
        _userService = userService,
        super(const UserState()) {
    on<EventLoginUser>(onUserLogin);
    on<EventUserEditarPswd>(onEditarPswd);
    on<EventUserLogout>(onUserLogout);
  }

  Future<void> onUserLogin(
      EventLoginUser event, Emitter<UserState> emit) async {
    if (state.status == UserStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final userLogin = await _userService.login(event.user);

      if (userLogin[1]) {
        return emit(
            state.copyWith(status: UserStatus.success, response: userLogin[0]));
      } else {
        return emit(
            state.copyWith(status: UserStatus.failure, response: userLogin[0]));
      }
    }
  }

  Future<void> onEditarPswd(
      EventUserEditarPswd event, Emitter<UserState> emit) async {
    if (state.status == UserStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final newPswd = await _userService.putPswd(event.user);

      if (newPswd[1]) {
        return emit(
            state.copyWith(response: newPswd[0], status: UserStatus.success));
      } else {
        return emit(
            state.copyWith(response: newPswd[0], status: UserStatus.failure));
      }
    }
  }

  onUserLogout(EventUserLogout event, Emitter<UserState> emit) async {
    await _userService.logout();
    emit(const UserState());
  }
}
