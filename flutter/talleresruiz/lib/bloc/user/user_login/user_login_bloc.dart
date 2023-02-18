import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../main.dart';

part './user_login_event.dart';
part './user_login_state.dart';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final UserServiceAbs _userService;

  UserLoginBloc(
      {required UserLoginBody login,
      required UserServiceAbs userService})
      : assert(userService != null),
      _userService = userService,
        super(const UserLoginState()) {
    //loginRepo = GetIt.I.get<LoginRepository>();
    on<UserLoginFetched>(onUserLogin);
  }

  //late LoginRepository loginRepo;

  Future<void> onUserLogin(
      UserLoginFetched event, Emitter<UserLoginState> emit) async {
    if (state.status == UserLoginStatus.initial) {
      //final userLogin = await loginRepo.loginUser(event.login);
      await Future.delayed(const Duration(milliseconds: 500));
      final userLogin = await _userService.login(event.userLogin);

      if (userLogin[1]) {
        return emit(state.copyWith(
            status: UserLoginStatus.success, userLogin: userLogin[0]));
      } else {
        return emit(state.copyWith(
            status: UserLoginStatus.failure, userLogin: userLogin[0]));
      }
    }
  }
}
