part of 'cita_bloc.dart';

enum CitaStatus { initial, success, failure }

class CitaState extends Equatable {
  const CitaState({this.status = CitaStatus.initial, this.response});

  final CitaStatus status;
  final dynamic response;

  CitaState copyWith({CitaStatus? status, dynamic response}) {
    return CitaState(
        status: status ?? this.status, response: response ?? this.response);
  }

  @override
  List<Object> get props => [];
}
