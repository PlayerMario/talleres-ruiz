import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../main.dart';

part './login_event.dart';
part './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginBody login}) : super(const LoginState()) {
    on<LoginFetched>(onLoginUsuario);
  }

  Future<void> onLoginUsuario (LoginFetched event, Emitter<LoginState> emit) async {
    if (state.status == LoginStatus.initial) {
      final userLogin = await loginUser(event.login);

      if(userLogin[1]) {
        return emit(state.copyWith(
          status: LoginStatus.success,
          userLogin: userLogin[0]));
      } else {
        return emit(state.copyWith(
          status: LoginStatus.failure,
          userLogin: userLogin[0]));
      }
    }
  }
}
