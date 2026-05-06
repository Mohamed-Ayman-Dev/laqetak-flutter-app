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
import 'package:invastro/src/config/themes/text_styles.dart';

import 'colors.dart';

export 'colors.dart';
export 'gradients.dart';

abstract class CustomTheme {
  // Contains the information about the light theme
  static const String appFontFamily = 'IBMPlexSansArabic';

  static InputDecoration outlinedBorderInputDecoration = InputDecoration(
    // contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    hintStyle: AppTextStyles.hintTextStyle,
    filled: true,
    focusColor: AppColors.primaryColor,
    fillColor: Colors.white,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: AppColors.fieldBorderColor),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: AppColors.fieldBorderColor),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: AppColors.fieldBorderColor),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: AppColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(7)),
      borderSide: BorderSide(color: AppColors.errorTextColor),
    ),
  );
  static ThemeData lightTheme = ThemeData(
    // visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: appFontFamily,
    highlightColor: AppColors.primaryColor.withOpacity(0.2),
    primaryColor: AppColors.primaryColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.backgroundColor,
      elevation: 0,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      backgroundColor: AppColors.navBarBackgroundColor,
      selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
      unselectedIconTheme: IconThemeData(color: AppColors.backgroundColor),
    ),
    splashColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
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
        fontFamily: appFontFamily,
      ),
    ),
    listTileTheme: const ListTileThemeData(textColor: AppColors.tileTextColor),
    textTheme: TextTheme(
      bodySmall: AppTextStyles.bodySmall,
      bodyMedium: AppTextStyles.bodyMedium,
      titleMedium: AppTextStyles.titleMedium,
      headlineLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.titleTextColor,
      ),
      headlineMedium: AppTextStyles.headlineMedium,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
      titleSmall: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.tileTextColor,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF8B8B8B),
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
          fontSize: 16.sp,
          fontFamily: appFontFamily,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        maximumSize: Size(double.infinity, 48.h),
        minimumSize: Size(double.infinity, 48.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: appFontFamily,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
        elevation: 0,
        maximumSize: Size(double.infinity, 48.h),
        minimumSize: Size(double.infinity, 48.h),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        side: BorderSide(color: AppColors.primaryColor),
      ),
    ),
    dividerTheme: DividerThemeData(color: AppColors.thirdColor),
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
  // static ThemeData darkTheme = ThemeData.dark().copyWith(
  //   colorScheme: const ColorScheme.dark(
  //     primary: AppColors.primaryDark,
  //     secondary: AppColors.accentDark,
  //     background: AppColors.backgroundDark,
  //     brightness: Brightness.dark,
  //   ),
  //   primaryColor: AppColors.primaryDark,
  //   primaryColorLight: AppColors.primaryDark.withAlpha(150),
  //   splashColor: AppColors.backgroundDark,
  //   highlightColor: AppColors.backgroundDark,
  //   scaffoldBackgroundColor: const Color(0xFF303030),
  //   backgroundColor: AppColors.backgroundDark,
  //   toggleableActiveColor: AppColors.accentDark,
  //   textSelectionTheme: const TextSelectionThemeData(cursorColor: _cursorColor),
  //   sliderTheme: SliderThemeData(
  //     thumbColor: AppColors.accentDark,
  //     activeTrackColor: AppColors.accentDark.withAlpha(180),
  //     activeTickMarkColor: AppColors.primaryDark,
  //     inactiveTrackColor: AppColors.accentDark.withAlpha(100),
  //     inactiveTickMarkColor: AppColors.primaryDark,
  //   ),
  //   appBarTheme: const AppBarTheme(
  //     systemOverlayStyle: SystemUiOverlayStyle.light,
  //     color: Color(0xFF303030),
  //     elevation: 0,
  //     titleTextStyle: TextStyle(
  //       fontSize: 20,
  //       color: Colors.white,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     iconTheme: IconThemeData(
  //       color: Colors.white,
  //     ),
  //   ),
  //   iconTheme: const IconThemeData(
  //     color: Colors.white,
  //   ),
  //   indicatorColor: Colors.white,
  //   elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //       primary: AppColors.accentDark,
  //       padding: const EdgeInsets.symmetric(
  //         horizontal: 20,
  //         vertical: 10,
  //       ),
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: ThemeGuide.borderRadius,
  //       ),
  //     ),
  //   ),
  //   outlinedButtonTheme: OutlinedButtonThemeData(
  //     style: OutlinedButton.styleFrom(
  //       primary: AppColors.accentDark,
  //       backgroundColor: AppColors.accentDark.withAlpha(20),
  //       side: const BorderSide(width: 0, color: Colors.transparent),
  //     ),
  //   ),
  //   inputDecorationTheme: const InputDecorationTheme(
  //     filled: true,
  //     contentPadding: EdgeInsets.symmetric(
  //       vertical: 12,
  //       horizontal: 16,
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       borderSide: BorderSide(width: 2, color: AppColors.accentDark),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       borderSide: BorderSide(width: 2, color: AppColors.accentDark),
  //     ),
  //     errorBorder: OutlineInputBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       borderSide: BorderSide(width: 2, color: Colors.red),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       borderSide: BorderSide(width: 2, color: Colors.transparent),
  //     ),
  //     disabledBorder: OutlineInputBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       borderSide: BorderSide(width: 2, color: Colors.transparent),
  //     ),
  //     errorMaxLines: 3,
  //     hintStyle: TextStyle(
  //       fontWeight: FontWeight.w600,
  //     ),
  //     errorStyle: TextStyle(
  //       fontWeight: FontWeight.w600,
  //     ),
  //   ),
  //   buttonTheme: const ButtonThemeData(
  //     highlightColor: AppColors.buttonHighlightColorDark,
  //     splashColor: AppColors.buttonSplashColorDark,
  //     disabledColor: AppColors.mDisabledColor,
  //     padding: EdgeInsets.all(12),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: ThemeGuide.borderRadius,
  //       side: BorderSide(
  //         width: 2,
  //         color: AppColors.accentDark,
  //       ),
  //     ),
  //   ),
  //   textTheme: ThemeData.dark().textTheme.copyWith(
  //         button: const TextStyle(color: AppColors.accentDark),
  //       ),
  // );
}
