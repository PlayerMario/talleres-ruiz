part of 'user_bloc.dart';

enum UserStatus { initial, success, failure }

class UserState extends Equatable {
  const UserState({this.status = UserStatus.initial, this.response});

  final UserStatus status;
  final dynamic response;

  UserState copyWith({UserStatus? status, dynamic response}) {
    return UserState(
        status: status ?? this.status, response: response ?? this.response);
  }

  @override
  List<Object> get props => [];
}
