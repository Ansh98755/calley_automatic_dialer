part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpInitial extends OtpState {}

class OtpVerifying extends OtpState {}

class OtpVerifySuccess extends OtpState {
  final String message;
  OtpVerifySuccess(this.message);

  @override
  List<Object> get props => [message];
}


class OtpVerifyFailure extends OtpState {
  final String error;
  OtpVerifyFailure(this.error);

  @override
  List<Object> get props => [error];
}
