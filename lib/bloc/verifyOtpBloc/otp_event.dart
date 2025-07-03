part of 'otp_bloc.dart';


abstract class OtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OtpVerifyRequested extends OtpEvent {
  final String email;
  final String otp;

  OtpVerifyRequested(this.email, this.otp);

  @override
  List<Object> get props => [email, otp];
}
class OtpResendRequested extends OtpEvent {
  final String email;
  OtpResendRequested(this.email);
  @override
  List<Object> get props => [email];
}