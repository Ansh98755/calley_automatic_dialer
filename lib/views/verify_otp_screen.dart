import 'package:calley_automatic_dialer/utils/assets_constants/assets_constants.dart';
import 'package:calley_automatic_dialer/utils/color_constants/color_constants.dart';
import 'package:calley_automatic_dialer/utils/custom_log_function/custom_log_function.dart';
import 'package:calley_automatic_dialer/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_routing/app_routing.dart';
import '../bloc/verifyOtpBloc/otp_bloc.dart';
class VerifyOtpScreen extends StatefulWidget {
  final String? email;
  const VerifyOtpScreen({Key? key, this.email}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController otpController = TextEditingController();
  String? email;
  String? mobileNumber;
  bool isDialogShowing = false;


  @override
  void initState() {
    super.initState();
    email = widget.email;
    if (email == null) {
      _loadDataFromPrefs();
    }
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('user_email');
      mobileNumber = prefs.getString('user_mobile_number');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) async {
      if (state is OtpVerifying) {
        isDialogShowing = true;
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        );
      } else {
        if (isDialogShowing) {
          Navigator.of(context, rootNavigator: true).pop();
          isDialogShowing = false;
        }
      }

      if (state is OtpVerifySuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted) {
          context.goNamed(AppRouteEnum.homeScreen.name);
        }
      }

      if (state is OtpVerifyFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error)),
        );
      }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    AssetsConstants.applogo,
                    height: 70,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Whatsapp OTP\nVerification',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Please ensure that the email id mentioned is valid as we have sent an OTP to your email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey.shade400,
                      activeColor: ColorConstants.colorCBD5E1,
                      selectedColor: Colors.blue,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    onChanged: (value) {},
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '+91 $mobileNumber',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    if (email != null) {
                      context.read<OtpBloc>().add(OtpResendRequested(email!));
                    }
                  },
                  child: const Text(
                    "Didn't receive OTP code? Resend OTP",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (email != null && otpController.text.isNotEmpty) {
                          context.read<OtpBloc>().add(
                            OtpVerifyRequested(email!, otpController.text.trim()),
                          );
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0057FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Verify',
                        style: TextStyleConstants.inter15W700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}