import 'package:calley_automatic_dialer/utils/color_constants/color_constants.dart';
import 'package:calley_automatic_dialer/utils/screen_size_config/screen_size_config.dart';
import 'package:calley_automatic_dialer/utils/string_constants/string_constants.dart';
import 'package:calley_automatic_dialer/views/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_routing/app_routing.dart';
import 'bloc/registerBloc/register_bloc.dart';
import 'bloc/verifyOtpBloc/otp_bloc.dart';
part 'my_app.dart';


void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}