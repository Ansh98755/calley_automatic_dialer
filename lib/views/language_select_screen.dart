import 'package:calley_automatic_dialer/utils/text_style_constants/text_style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../app_routing/app_routing.dart';
import '../utils/color_constants/color_constants.dart';

class LanguageSelectScreen extends StatefulWidget {
  const LanguageSelectScreen({super.key});

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen> {
  String? _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _languages = [
      {'name': 'English', 'greeting': 'Hi'},
      {'name': 'Hindi', 'greeting': 'नमस्ते'},
      {'name': 'Bengali', 'greeting': 'হ্যালো'},
      {'name': 'Kannada', 'greeting': 'ನಮಸ್ಕಾರ'},
      {'name': 'Punjabi', 'greeting': 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'},
      {'name': 'Tamil', 'greeting': 'வணக்கம்'},
      {'name': 'Telugu', 'greeting': 'హలో'},
      {'name': 'French', 'greeting': 'Bonjour'},
      {'name': 'Spanish', 'greeting': 'Hola'},
    ];
    return Scaffold(
      body: Container(
        color: ColorConstants.themeColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 45),
          child: SingleChildScrollView(
            child: Column(
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Choose Your Language',
                        style: TextStyleConstants.inter20W500,
                      ),
                    ],
                  ),
                SizedBox(height: 13),
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ColorConstants.colorCBD5E1
                    )
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20,left: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: _languages.map((language) {
                        return Column(
                          children: [
                            ListTile(
                              dense:true,
                              title: Text(
                                language['name']!,
                                style: TextStyleConstants.inter15W500
                              ),
                              subtitle: Text(
                                language['greeting']!,
                                style: TextStyleConstants.inter14W400
                              ),
                              trailing: Radio<String>(
                                value: language['name']!,
                                groupValue: _selectedLanguage,
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedLanguage = value;
                                    print('Selected language: $value');
                                  });
                                },
                                activeColor: ColorConstants.blackColor,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedLanguage = language['name']!;
                                  print('Selected language: ${language['name']}');
                                });
                              },
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                GestureDetector(
                  onTap: () {
                    context.goNamed(AppRouteEnum.loginScreen.name);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration:BoxDecoration(
                      color: ColorConstants.color2563EB,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 16),
                      child: Text(
                        'Select',
                        textAlign: TextAlign.center,
                        style: TextStyleConstants.inter15W700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
