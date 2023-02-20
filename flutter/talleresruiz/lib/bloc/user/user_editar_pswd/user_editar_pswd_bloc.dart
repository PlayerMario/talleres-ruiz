import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part './user_editar_pswd_event.dart';
part './user_editar_pswd_state.dart';

class UserEditarPswdBloc extends Bloc<UserEditarPswdEvent, UserEditarPswdState> {
  final UserServiceAbs _userService;

  UserEditarPswdBloc(
      {required UserServiceAbs userService, UserEditarPswdBody? pswd})
      : assert(userService != null),
        _userService = userService,
        super(const UserEditarPswdState()) {
    on<UserEditarPswdFetched>(onEditarPswd);
  }

  Future<void> onEditarPswd(
      UserEditarPswdFetched event, Emitter<UserEditarPswdState> emit) async {
    if (state.status == UserEditarPswdStatus.initial) {
      await Future.delayed(const Duration(milliseconds: 500));
      final newPswd = await _userService.putPswd(event.pswd);

      if (newPswd[1]) {
        return emit(state.copyWith(
            pswd: newPswd[0], status: UserEditarPswdStatus.success));
      } else {
        return emit(state.copyWith(
            pswd: newPswd[0], status: UserEditarPswdStatus.failure));
      }
    }
  }
}
