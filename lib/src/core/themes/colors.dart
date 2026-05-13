import 'package:flutter/material.dart';

/// All the colors used in the application are defined here
///
/// Update the colors as desired with their dark mode variations below them.
abstract class AppColors {
  // objects Colors
  static const Color primaryColor = Color(0xFFB58934);
  static const Color secondaryColor = Color(0xFFFEE086);
  static const Color thirdColor = Color(0xFFE5E5E5);

  static const Color iconButtonIconColor = primaryColor;

  // background Colors
  static const Color backgroundColor = Colors.white;
  static const Color unSelectedRadioBKColor = Color(0XFFD1D1D6);
  static const Color selectedRadioBKColor = primaryColor;
  static Color disabledButtonColorBk = Colors.grey[200]!;
  static const Color searchBKColor = Color(0XFFF6F6F6);
  static const Color greyScaffoldBKColor = Color(0XFFFBFBFB);
  static const Color deleteIconButtonBKColor = Color(0XFFEAEAEA);
  static const Color myMessageBKColor = Color(0XFFE2E2E2);
  static const Color sellerNumberBKColor = Color(0XFFF0F0F0);

  static const Color otherMessageBKColor = Color.fromRGBO(254, 224, 134, 0.56);

  static const Color notificationBk = Color(0XFFE0E0E0);
  static const Color appBarBackGroundColor = Colors.white;
  static const Color navBarBackgroundColor = Color(0xFF323539);

  // text colors
  static const Color labelTextColor = Colors.black;
  static const Color labelGreyTextColor = Color(0xFF8E8E93);
  static const Color headlineGreyTextColor = Color(0xFF8E8E93);
  static const Color inputTextColor = Colors.black;
  static const Color buttonTextColor = Color(0xFF1D1D1D);
  static const Color hintColor = Color(0xFF8E8E93);
  static const Color bodyGreyTextColor = Color(0xFF737373);
  static const Color dateTextColor = Color(0XFF8F96A3);
  static const Color bodyTextColor = Color(0xFF181818);
  static const Color bodySmallGreyTextColor = Color(0XFFABABAB);
  static const Color tileTextColor = Color(0xFF333333);
  static const Color bodyChatTextColor = Color(0XFF6E6E6E);
  static const Color drawerHeaderTextColor = Color(0xFF3A3A3C);
  static const Color descTextColor = Color(0xFF5D5D5D);
  static const Color sellerLabelTextColor = Color(0xFF7D7D7D);
  static const Color numberLabelTextColor = Color(0xFF212121);
  static const Color labelBlackTextColor = Color(0XFF0D0D0E);
  static const Color priceBlackTextColor = Color(0XFF282828);

  static const Color textButtonTextColor = Color(0XFF181818);
  static const Color titleTextColor = Color(0XFF1D1D1D);
  static const Color errorTextColor = Color(0xFFFF0E0E);

  // border colors
  static const Color fieldBorderColor = Color(0xFF8E8E93);
  static const Color borderColor = Color(0xFF8E8E93);
  static const Color buttonBorderColor = Color(0xFFD5D5D5);
  static const Color notificationBorderColor = Color(0xFF868686);
  static const Color conversationBorderColor = Color(0xFFC5C5C5);
  static const Color chatFieldBorderColor = Color(0xFFD9D9D9);
  static const Color questionBorderColor = Color(0xFFBFBFBF);
  static const Color containerBorderColor = Color(0xFF818181);
  static const Color reportBorderColor = Color(0xFFBD3636);

  // other colors
  static const Color cursorColor = Color(0xFF8B8B8B);
  static const Color iconUnSelectedColor = Color(0xFF838383);
  static const Color dividerColor = Color(0xFFDADADA);
  static const Color drawerDividerColor = Color(0xFFE9E9E9);
  static const Color detailsDividerColor = Color(0XFFE2E2E2);

  static const Color verticalDividerColor = Color(0xFFF2F2F2);
  static const Color expiredAdLabelColor = Color(0xFFE55A5A);
  static const Color drawerIconColor = Color(0xFF8E9CA9);
}
