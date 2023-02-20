part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class EventLoginUser extends UserEvent {
  const EventLoginUser(this.user);

  final UserLoginBody user;
}

class EventUserEditarPswd extends UserEvent {
  const EventUserEditarPswd(this.user);

  final UserEditarPswdBody user;
}

class EventUserLogout extends UserEvent {}

class EventUserSessionExpired extends UserEvent {}
