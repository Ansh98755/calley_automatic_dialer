part of 'register_bloc.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
}

class OtpSending extends RegisterState {}

class OtpSentSuccess extends RegisterState {}

class OtpSentFailure extends RegisterState {
  final String error;
  OtpSentFailure(this.error);
}
