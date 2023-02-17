part of './login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginFetched extends LoginEvent {
  const LoginFetched(this.login);

  final LoginBody login;
}

class UserLoggedOut extends LoginEvent {}

class SessionExpiredEvent extends LoginEvent {}
