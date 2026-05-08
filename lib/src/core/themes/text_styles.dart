import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/theme.dart';

/// All the text styles used in the application are defined here

abstract class AppTextStyles {
  static TextStyle labelSmall = TextStyle(
    fontSize: 14.sp,
    color: AppColors.bodySmallGreyTextColor,
    fontWeight: FontWeight.w400,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle labelMedium = TextStyle(
    fontSize: 16.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle labelLarge = TextStyle(
    fontSize: 16.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontFamily: CustomTheme.appFontFamily,
    color: AppColors.bodyTextColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle titleMedium = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle buttonsTextStyle = TextStyle(
    color: AppColors.buttonTextColor,
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle hintTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.hintColor,
    fontFamily: CustomTheme.appFontFamily,
  );

  static TextStyle textButtonTextStyle = TextStyle(
    color: AppColors.textButtonTextColor,
    fontSize: 14.sp,
    fontFamily: CustomTheme.appFontFamily,
    fontWeight: FontWeight.w700,
  );
  static TextStyle inputTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.inputTextColor,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
  );
  static TextStyle dropDownTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    fontFamily: CustomTheme.appFontFamily,
    color: AppColors.labelTextColor,
  );
  static TextStyle headlineMedium = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.labelTextColor,
    fontFamily: CustomTheme.appFontFamily,
  );

  ///------------------------------------

  static TextStyle headlineLarge = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    fontFamily: CustomTheme.appFontFamily,
    color: Colors.white,
  );

  static TextStyle titleLarge = TextStyle(
    color: Colors.white,
    fontFamily: CustomTheme.appFontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
  );
}
