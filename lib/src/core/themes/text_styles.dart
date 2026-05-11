import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/constant.dart';
import 'package:invastro/src/core/themes/theme.dart';

/// All the text styles used in the application are defined here

abstract class AppTextStyles {
  static TextStyle langLabel = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle labelSmall = TextStyle(
    fontSize: 14.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w400,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    color: AppColors.bodyGreyTextColor,
    fontWeight: FontWeight.w400,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle headlineMedium = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.labelTextColor,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle headlineSmall = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.headlineGreyTextColor,
    fontFamily: Constant.fontFamily,
  );

  static TextStyle inputTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.inputTextColor,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle hintTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.hintColor,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle filterButtonTextStyle = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle labelMedium = TextStyle(
    fontSize: 13.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w700,
    fontFamily: Constant.fontFamily,
  );

  ///------------------------------------

  static TextStyle labelLarge = TextStyle(
    fontSize: 16.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontFamily: Constant.fontFamily,
    color: AppColors.bodyTextColor,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    color: AppColors.labelTextColor,
    fontWeight: FontWeight.w500,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle titleMedium = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle titleSmall = TextStyle(
    color: Colors.black,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: Constant.fontFamily,
  );
  static TextStyle buttonsTextStyle = TextStyle(
    color: AppColors.buttonTextColor,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textButtonTextStyle = TextStyle(
    color: AppColors.textButtonTextColor,
    fontSize: 14.sp,
    fontFamily: Constant.fontFamily,
    fontWeight: FontWeight.w700,
  );

  static TextStyle headlineLarge = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w700,
    height: 1.2,
    fontFamily: Constant.fontFamily,
    color: Colors.white,
  );

  static TextStyle titleLarge = TextStyle(
    color: Colors.white,
    fontFamily: Constant.fontFamily,
    fontSize: 36.sp,
    fontWeight: FontWeight.w700,
  );
}
