import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talleresruiz/services/authentication/authentication_service.dart';
import '../../main.dart';

part './login_event.dart';
part './login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationService _authenticationService;

  LoginBloc(
      {required LoginBody login,
      required AuthenticationService authenticationService})
      : assert(authenticationService != null),
      _authenticationService = authenticationService,
        super(const LoginState()) {
    //loginRepo = GetIt.I.get<LoginRepository>();
    on<LoginFetched>(onLoginUsuario);
  }

  //late LoginRepository loginRepo;

  Future<void> onLoginUsuario(
      LoginFetched event, Emitter<LoginState> emit) async {
    if (state.status == LoginStatus.initial) {
      //final userLogin = await loginRepo.loginUser(event.login);
      final userLogin = await _authenticationService.signIn(event.login);

      if (userLogin[1]) {
        return emit(state.copyWith(
            status: LoginStatus.success, userLogin: userLogin[0]));
      } else {
        return emit(state.copyWith(
            status: LoginStatus.failure, userLogin: userLogin[0]));
      }
    }
  }
}
