part of 'user_editar_pswd_bloc.dart';

enum UserEditarPswdStatus { initial, success, failure }

class UserEditarPswdState extends Equatable {
  const UserEditarPswdState(
      {this.status = UserEditarPswdStatus.initial, this.pswd});

  final UserEditarPswdStatus status;
  final dynamic pswd;

  UserEditarPswdState copyWith({UserEditarPswdStatus? status, dynamic pswd}) {
    return UserEditarPswdState(
        status: status ?? this.status, pswd: pswd ?? this.pswd);
  }

  @override
  List<Object> get props => [];
}
