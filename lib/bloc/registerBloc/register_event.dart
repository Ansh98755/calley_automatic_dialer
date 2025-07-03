part of 'register_bloc.dart';
abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  RegisterSubmitted(this.username, this.email, this.password);
}

class SendOtpRequested extends RegisterEvent {
  final String email;

  SendOtpRequested(this.email);
}

