import 'dart:convert';

import 'package:calley_automatic_dialer/utils/custom_log_function/custom_log_function.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<OtpVerifyRequested>((event, emit) async {
      emit(OtpVerifying());

      final url = Uri.parse('https://mock-api.calleyacd.com/api/auth/verify-otp');
      final body = jsonEncode({'email': event.email, 'otp': event.otp});

      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseBody = jsonDecode(response.body);
          final message = responseBody['message'] ?? 'OTP Verified';
          customDebugLogs(message: '$message');
          SnackBar(content: Text('Otp Verified'));
          emit(OtpVerifySuccess(message));
        } else {
          emit(OtpVerifyFailure('OTP verification failed: ${response.body}'));
        }
      } catch (e) {
        emit(OtpVerifyFailure('OTP verification failed: $e'));
      }
    });
    on<OtpResendRequested>((event, emit) async {
      emit(OtpVerifying());
      final url = Uri.parse('https://mock-api.calleyacd.com/api/auth/send-otp');
      final body = jsonEncode({'email': event.email});
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: body,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(OtpVerifyFailure('OTP resent successfully!'));
        } else {
          emit(OtpVerifyFailure('Failed to resend OTP: ${response.body}'));
        }
      } catch (e) {
        emit(OtpVerifyFailure('Failed to resend OTP: $e'));
      }
    });


  }
}
