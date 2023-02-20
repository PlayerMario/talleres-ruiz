part of 'user_editar_pswd_bloc.dart';

abstract class UserEditarPswdEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserEditarPswdFetched extends UserEditarPswdEvent {
  UserEditarPswdFetched(this.pswd);

  final UserEditarPswdBody pswd;
}
