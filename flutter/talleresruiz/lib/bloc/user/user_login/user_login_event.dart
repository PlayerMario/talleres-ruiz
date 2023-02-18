part of 'user_login_bloc.dart';

abstract class UserLoginEvent extends Equatable {
  const UserLoginEvent();

  @override
  List<Object> get props => [];
}

class UserLoginFetched extends UserLoginEvent {
  const UserLoginFetched(this.userLogin);

  final UserLoginBody userLogin;
}

class UserLogoutFetched extends UserLoginEvent {}

class UserSessionExpired extends UserLoginEvent {}
