import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_constants/color_constants.dart';


abstract final class TextStyleConstants{
  static final TextStyle inter20W500 =GoogleFonts.inter(fontSize:FontSize.s20,fontWeight: FontWeightManager.medium,color: ColorConstants.blackColor);
  static final TextStyle inter15W500 =GoogleFonts.inter(fontSize:FontSize.s15,fontWeight: FontWeightManager.medium,color: ColorConstants.blackColor);
  static final TextStyle inter14W500 =GoogleFonts.inter(fontSize:FontSize.s14,fontWeight: FontWeightManager.medium,color: ColorConstants.whiteColor);
  static final TextStyle inter13W500 =GoogleFonts.inter(fontSize:FontSize.s13,fontWeight: FontWeightManager.medium,color: ColorConstants.whiteColor);
  static final TextStyle inter15W600 =GoogleFonts.inter(fontSize:FontSize.s15,fontWeight: FontWeightManager.semiBold,color: ColorConstants.color2563EB);
  static final TextStyle inter14W600 =GoogleFonts.inter(fontSize:FontSize.s14,fontWeight: FontWeightManager.semiBold,color: ColorConstants.color2563EB);
  static final TextStyle inter16W600 =GoogleFonts.inter(fontSize:FontSize.s16,fontWeight: FontWeightManager.semiBold,color: ColorConstants.color2563EB);
  static final TextStyle inter12W400=GoogleFonts.inter(fontSize:FontSize.s12,fontWeight: FontWeightManager.regular,color: ColorConstants.color666666);
  static final TextStyle inter14W400=GoogleFonts.inter(fontSize:FontSize.s14,fontWeight: FontWeightManager.regular,color: ColorConstants.color666666);
  static final TextStyle inter13W400=GoogleFonts.inter(fontSize:FontSize.s13,fontWeight: FontWeightManager.regular,color: ColorConstants.color666666);
  static final TextStyle inter15W400=GoogleFonts.inter(fontSize:FontSize.s15,fontWeight: FontWeightManager.regular,color: ColorConstants.color666666);
  static final TextStyle inter15W700=GoogleFonts.inter(fontSize:FontSize.s15,fontWeight: FontWeightManager.bold,color: ColorConstants.whiteColor);
  static final TextStyle inter18W600=GoogleFonts.inter(fontSize:FontSize.s18,fontWeight: FontWeightManager.semiBold,color: ColorConstants.blackColor);
  static final TextStyle inter32W700=GoogleFonts.inter(fontSize:FontSize.s32,fontWeight: FontWeightManager.bold,color: ColorConstants.blackColor);
}
abstract final class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

abstract final class FontSize {
  static final double s10 = 10.0;
  static final double s11 = 11.0;
  static final double s12 = 12.0;
  static final double s13 = 13.0;
  static final double s14 = 14.0;
  static final double s15 = 15.0;
  static final double s16 = 16.0;
  static final double s17 = 17.0;
  static final double s18 = 18.0;
  static final double s20 = 20.0;
  static final double s40 = 40.0;
  static final double s24 = 24.0;
  static final double s28 = 28.0;
  static final double s32 = 32.0;

}