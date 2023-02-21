part of 'admec_bloc.dart';

enum AdMecStatus { initial, success, failure }

class AdMecState extends Equatable {
  const AdMecState({this.status = AdMecStatus.initial, this.response});

  final AdMecStatus status;
  final dynamic response;

  AdMecState copyWith({AdMecStatus? status, dynamic response}) {
    return AdMecState(
        status: status ?? this.status, response: response ?? this.response);
  }

  @override
  List<Object> get props => [];
}
