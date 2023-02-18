part of 'user_login_bloc.dart';

enum UserLoginStatus { initial, success, failure }

class UserLoginState extends Equatable {
  const UserLoginState({this.status = UserLoginStatus.initial, this.userLogin});

  final UserLoginStatus status;
  final dynamic userLogin;

  UserLoginState copyWith({UserLoginStatus? status, dynamic userLogin}) {
    return UserLoginState(
        status: status ?? this.status, userLogin: userLogin ?? this.userLogin);
  }

  @override
  List<Object> get props => [];
}
