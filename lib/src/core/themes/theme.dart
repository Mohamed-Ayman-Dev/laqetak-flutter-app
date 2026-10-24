// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';

import '../constants/constant.dart';
import 'colors.dart';

export 'colors.dart';
export 'gradients.dart';

abstract class CustomTheme {
  // Contains the information about the light theme

  static InputDecoration outlinedBorderInputDecoration = InputDecoration(
    // contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    hintStyle: AppTextStyles.hintTextStyle,
    filled: true,
    focusColor: AppColors.primaryColor,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.inputBorderColor),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: AppColors.errorTextColor),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: Constant.fontFamily,
    highlightColor: AppColors.secondaryColor.withOpacity(0.08),
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.secondaryColor,
      unselectedItemColor: AppColors.iconUnSelectedColor,
      elevation: 0,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      backgroundColor: AppColors.navBarBackgroundColor,
      selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
      unselectedIconTheme: IconThemeData(color: AppColors.iconUnSelectedColor),
    ),
    scrollbarTheme: ScrollbarThemeData(
      trackColor: WidgetStateProperty.all(
        AppColors.secondaryColor.withOpacity(0.1),
      ),
      thumbColor: WidgetStateProperty.all(
        AppColors.secondaryColor.withOpacity(0.7),
      ),
      trackBorderColor: WidgetStateProperty.all(Colors.transparent),
    ),
    splashColor: AppColors.secondaryColor.withOpacity(0.08),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.backgroundColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secondaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackGroundColor,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        color: AppColors.tileTextColor,
        fontWeight: FontWeight.bold,
        fontFamily: Constant.fontFamily,
      ),
    ),
    listTileTheme: const ListTileThemeData(textColor: AppColors.tileTextColor),
    textTheme: TextTheme(
      bodySmall: AppTextStyles.bodySmall,
      bodyMedium: AppTextStyles.bodyMedium,
      titleMedium: AppTextStyles.titleMedium,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
      titleSmall: AppTextStyles.titleSmall,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.secondaryColor,
      selectionColor: AppColors.tealLight,
      selectionHandleColor: AppColors.secondaryColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all(AppColors.iconButtonIconColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: AppTextStyles.hintTextStyle,
      errorStyle: const TextStyle(
        fontSize: 13,
        color: AppColors.errorTextColor,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.fieldBorderColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.fieldBorderColor),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.fieldBorderColor),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.errorTextColor),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.errorTextColor),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          color: AppColors.buttonTextColor,
          fontSize: 14.sp,
          fontFamily: Constant.fontFamily,
          fontWeight: FontWeight.w400,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        maximumSize: Size(double.infinity, 48.h),
        minimumSize: Size(double.infinity, 48.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontFamily: Constant.fontFamily,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        maximumSize: Size(double.infinity, 48.h),
        minimumSize: Size(double.infinity, 48.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        side: BorderSide(color: AppColors.primaryColor),
      ),
    ),

    dividerTheme: DividerThemeData(color: AppColors.dividerColor),
    radioTheme: RadioThemeData(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 15,
      fillColor: MaterialStateProperty.all(AppColors.fieldBorderColor),
    ),
    checkboxTheme: CheckboxThemeData(
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      splashRadius: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      fillColor: MaterialStateProperty.all(AppColors.primaryColor),
    ),
  );

  // Contains the information about the dark theme
  static ThemeData darkTheme = ThemeData.dark().copyWith();
}
