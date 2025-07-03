import 'package:calley_automatic_dialer/utils/assets_constants/assets_constants.dart';
import 'package:calley_automatic_dialer/utils/color_constants/color_constants.dart';
import 'package:calley_automatic_dialer/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_routing/app_routing.dart';
import '../../bloc/registerBloc/register_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  bool agreeTerms = false;

  @override
  Future<void> saveEmailToPrefs(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
  }
  Future<void> saveMobileNumberToPrefs(String mobileNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_mobile_number',mobileNumber );
  }Future<void> saveNameToPrefs(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading || state is OtpSending) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => Center(child: CircularProgressIndicator()),
            );
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is OtpSentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is OtpSentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('OTP sent to your email!')),
            );
            context.goNamed(AppRouteEnum.verifyOtpScreen.name,
              extra: {'email': emailController.text.trim()},
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(AssetsConstants.applogo)],
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: ColorConstants.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorConstants.colorCBD5E1,
                    width: 1,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Column(
                      children: [
                        Text('Welcome!', style: TextStyleConstants.inter32W700),
                        SizedBox(height: 11),
                        Text('Please register to continue',
                            style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor)),
                        SizedBox(height: 22),

                        _buildInputField(
                            "Name", nameController, AssetsConstants.nameIcon, (
                            val) {
                          if (val == null || val
                              .trim()
                              .isEmpty) return 'Name is required';
                          return null;
                        }),
                        SizedBox(height: 20),
                        _buildInputField("Email address", emailController,
                            AssetsConstants.emailIcon, (val) {
                              if (val == null || val.isEmpty)
                                return 'Email is required';
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(val))
                                return 'Enter valid email';
                              return null;
                            }),

                        SizedBox(height: 20),
                        _buildInputField("Password", passwordController,
                            AssetsConstants.passwordIcon, (val) {
                              if (val == null || val.length < 3)
                                return 'Min 3 characters required';
                              return null;
                            }, isPassword: true),
                        SizedBox(height: 20),
                        _buildCountryCodeField(),
                        SizedBox(height: 20),
                        _buildInputField("Mobile number", mobileController,
                            AssetsConstants.mobilIcon, (val) {
                              if (val == null || val.length != 10)
                                return 'Enter 10 digit mobile number';
                              return null;
                            }, keyboardType: TextInputType.phone),

                        SizedBox(height: 20),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: agreeTerms,
                                onChanged: (val) {
                                  setState(() {
                                    agreeTerms = val!;
                                  });
                                },
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyleConstants.inter13W400
                                        .copyWith(color: ColorConstants.blackColor),
                                    children: [
                                      TextSpan(
                                        text: "I agree to the ",
                                        style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor)
                                      ),
                                      TextSpan(
                                        text: "Terms and Conditions",
                                        style:TextStyleConstants.inter15W400.copyWith(color: ColorConstants.color2563EB),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.color2563EB,
                            minimumSize: Size(324, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (!agreeTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(
                                      'Please agree to the Terms and Conditions')),
                                );
                                return;
                              }
                              await saveEmailToPrefs(emailController.text.trim());
                              await saveMobileNumberToPrefs(mobileController.text.trim());
                              await saveNameToPrefs(nameController.text.trim());
                              context.read<RegisterBloc>().add(
                                RegisterSubmitted(
                                  nameController.text.trim(),
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                          child: Text('Sign Up',
                              style: TextStyle(color: ColorConstants.whiteColor)),
                        ),

                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor),
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: Text("Sign In",
                                  style: TextStyleConstants.inter15W600
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _buildInputField(
      String hint,
      TextEditingController controller,
      String iconPath,
      String? Function(String?) validator, {
        bool isPassword = false,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Container(
      width: 324,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstants.colorCBD5E1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                obscureText: isPassword,
                validator: validator,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor),
                ),
                style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor),
              ),
            ),
            Image.asset(iconPath),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryCodeField() {
    return Container(
      width: 324,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstants.colorCBD5E1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image.asset(AssetsConstants.flagIcon, width: 24),
            SizedBox(width: 8),
            Text("+91",
                style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor)
            ),
            SizedBox(width: 8),
            Flexible(
                child: TextFormField(
                  style: TextStyleConstants.inter15W400.copyWith(color: ColorConstants.blackColor),
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                )
            ),
            Spacer(),
            Image.asset(AssetsConstants.whatsappIcon),
          ],
        ),
      ),
    );
  }
}
