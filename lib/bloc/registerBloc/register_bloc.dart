import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
part 'register_event.dart';
part 'register_state.dart';
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      final registerUrl = Uri.parse('https://mock-api.calleyacd.com/api/auth/register');
      final registerBody = jsonEncode({
        'username': event.username,
        'email': event.email,
        'password': event.password,
      });

      try {
        final registerResponse = await http.post(
          registerUrl,
          headers: {'Content-Type': 'application/json'},
          body: registerBody,
        );

        if (registerResponse.statusCode == 200 || registerResponse.statusCode == 201) {
          emit(RegisterSuccess());
          add(SendOtpRequested(event.email));
        } else {
          emit(RegisterFailure('Registration failed: ${registerResponse.statusCode}'));
        }
      } catch (e) {
        emit(RegisterFailure('Registration failed: $e'));
      }
    });

    on<SendOtpRequested>((event, emit) async {
      emit(OtpSending());

      final otpUrl = Uri.parse('https://mock-api.calleyacd.com/api/auth/send-otp');
      final otpBody = jsonEncode({'email': event.email});
      print('$otpBody');

      try {
        final otpResponse = await http.post(
          otpUrl,
          headers: {'Content-Type': 'application/json'},
          body: otpBody,
        );

        if (otpResponse.statusCode == 200 || otpResponse.statusCode == 201) {
          emit(OtpSentSuccess());
          print('OTP Response status: ${otpResponse.statusCode}');
          print('OTP Response body: ${otpResponse.body}');

        } else {
          emit(OtpSentFailure('Failed to send OTP: ${otpResponse.statusCode}'));
        }
      } catch (e) {
        emit(OtpSentFailure('Failed to send OTP: $e'));
      }
    });
  }
}

