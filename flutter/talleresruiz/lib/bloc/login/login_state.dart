part of './login_bloc.dart';

enum LoginStatus { initial, success, failure }

class LoginState extends Equatable {
  const LoginState({this.status = LoginStatus.initial, this.userLogin});

  final LoginStatus status;
  final dynamic userLogin;

  LoginState copyWith({LoginStatus? status, dynamic userLogin}) {
    return LoginState(
        status: status ?? this.status, userLogin: userLogin ?? this.userLogin);
  }

  @override
  List<Object> get props => [];
}
