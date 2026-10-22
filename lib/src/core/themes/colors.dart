import 'package:flutter/material.dart';

/// Design System Color Palette for **Laqetak (لقطتك)**
///
/// Follows modern Flutter design token best practices:
/// 1. **Brand Palette**: Core brand identity (Deep Navy + Vibrant Teal).
/// 2. **Neutral & Surface Palette**: Backgrounds, surfaces, cards, and canvas.
/// 3. **Typography Palette**: High, medium, and low emphasis text colors.
/// 4. **Borders & Dividers**: Subtle, structural, and state borders.
/// 5. **Feedback & States**: Success, error, warning, and disabled states.
/// 6. **Component Tokens**: Shimmer, Chat bubbles, Bottom navigation, Badges, etc.
abstract final class AppColors {
  AppColors._();

  // ===========================================================================
  // 1. BRAND PALETTE (هوية)
  // ===========================================================================

  /// Deep Navy - Base primary brand color (foundation, authority, professional)
  static const Color navyColor = Color(0xFF102A43);

  /// Vibrant Teal - Secondary accent brand color (spark of opportunity)
  static const Color tealColor = Color(0xFF0D9488);

  // Tonal variations for subtle backgrounds, chips, and hover/pressed states
  static const Color navyDark = Color(0xFF0B1D2F);
  static const Color navyLight = Color(0xFF243B53);
  static const Color navySurface = Color(0xFFF0F4F8);

  static const Color tealDark = Color(0xFF0F766E);
  static const Color tealLight = Color(0xFFCCFBF1);
  static const Color tealSurface = Color(0xFFF0FDFA);

  // Primary & Secondary Aliases
  static const Color primaryColor = navyColor;
  static const Color secondaryColor = tealColor;
  static const Color accentColor = tealColor;
  static const Color thirdColor = navySurface;

  // ===========================================================================
  // 2. NEUTRAL & SURFACE PALETTE
  // ===========================================================================

  static const Color backgroundColor = Colors.white;
  static const Color surfaceColor = Colors.white;
  static const Color greyScaffoldBKColor = Color(0xFFFBFBFB);
  static const Color searchBKColor = Color(0xFFF6F6F6);
  static const Color sellerNumberBKColor = Color(0xFFF0F0F0);
  static const Color buttonBackBKColor = Color(0xFFF0F4F8);
  static const Color uploadImageBKColor = Color(0xFFEFEFEF);
  static const Color notificationBk = Color(0xFFE0E0E0);
  static const Color deleteIconButtonBKColor = Color(0xFFEAEAEA);
  static const Color imagePlaceholderBKColor = Color(0xFFEEEEEE);

  static const Color appBarBackGroundColor = Colors.white;
  static const Color navBarBackgroundColor = Colors.white;

  // Overlays & Modal Barriers
  static const Color barrierColor = Color(0x33000000); // 20% opacity black
  static const Color barrierColorLight = Color(0x1F000000); // 12% opacity black
  static const Color barrierColorDark = Color(0xBF000000); // 75% opacity black
  static const Color overlayBlack54 = Colors.black54;

  // ===========================================================================
  // 3. TYPOGRAPHY PALETTE
  // ===========================================================================

  /// Primary high-emphasis text color
  static const Color labelTextColor = Colors.black;
  static const Color bodyTextColor = Color(0xFF181818);
  static const Color titleTextColor = primaryColor;
  static const Color textButtonTextColor = primaryColor;

  /// Secondary and muted text colors
  static const Color labelGreyTextColor = Color(0xFF8E8E93);
  static const Color headlineGreyTextColor = Color(0xFF8E8E93);
  static const Color hintColor = Color(0xFF8E8E93);
  static const Color bodyGreyTextColor = Color(0xFF737373);
  static const Color descTextColor = Color(0xFF5D5D5D);
  static const Color textGrey1Color = Color(0xFF7B7B7B);
  static const Color labelSmallGreyTextColor = Color(0xFF888888);
  static const Color bodySmallGreyTextColor = Color(0xFFABABAB);

  /// Specific Text Tokens
  static const Color inputTextColor = Colors.black;
  static const Color buttonTextColor = Colors.white;
  static const Color dateTextColor = Color(0xFF8F96A3);
  static const Color tileTextColor = Color(0xFF333333);
  static const Color bodyChatTextColor = Color(0xFF6E6E6E);
  static const Color drawerHeaderTextColor = Color(0xFF3A3A3C);
  static const Color sellerLabelTextColor = Color(0xFF7D7D7D);
  static const Color numberLabelTextColor = Color(0xFF212121);
  static const Color labelBlackTextColor = Color(0xFF0D0D0E);
  static const Color priceBlackTextColor = Color(0xFF282828);
  static const Color priceTextColor = secondaryColor;

  // ===========================================================================
  // 4. BORDERS & DIVIDERS
  // ===========================================================================

  static const Color inputBorderColor = Color(0xFFE4E4E7);
  static const Color fieldBorderColor = Color(0xFF8E8E93);
  static const Color borderColor = Color(0xFF8E8E93);
  static const Color dottedBorderColor = Color(0xFFC3C3C3);
  static const Color buttonBorderColor = Color(0xFFD5D5D5);
  static const Color notificationBorderColor = Color(0xFF868686);
  static const Color conversationBorderColor = Color(0xFFC5C5C5);
  static const Color chatFieldBorderColor = Color(0xFFD9D9D9);
  static const Color questionBorderColor = Color(0xFFBFBFBF);
  static const Color containerBorderColor = Color(0xFF818181);
  static const Color priceBorderColor = Color(0xFF8F8F8F);
  static const Color cardBorderColor = Color(0xFFF0F0F0);
  static const Color navBarBorderColor = Color(0xFFF3F2F8);

  static const Color dividerColor = Color(0xFFDADADA);
  static const Color drawerDividerColor = Color(0xFFE9E9E9);
  static const Color detailsDividerColor = Color(0xFFE2E2E2);
  static const Color verticalDividerColor = Color(0xFFF2F2F2);

  // ===========================================================================
  // 5. SEMANTIC & FEEDBACK PALETTE
  // ===========================================================================

  static const Color errorTextColor = Color(0xFFFF0E0E);
  static const Color errorColor = Color(0xFFD52F2F);
  static const Color errorDeepColor = Color(0xFFB00020);
  static const Color errorLightColor = Color(0xFFFFEBEE);
  static const Color reportBorderColor = Color(0xFFBD3636);
  static const Color deleteBorderColor = Color(0xFFD52F2F);

  static const Color successColor = secondaryColor;
  static const Color successDarkColor = Color(0xFF2E7D32);

  static const Color appFeedbackBKColor = primaryColor;
  static const Color appFeedSuccessBKColor = secondaryColor;

  static const Color disabledButtonColorBk = Color(0xFFEEEEEE);
  static const Color disabledTextColor = Color(0xFFBDBDBD);

  // ===========================================================================
  // 6. COMPONENT-SPECIFIC TOKENS
  // ===========================================================================

  // Interactive controls
  static const Color unSelectedRadioBKColor = Color(0xFFD1D1D6);
  static const Color selectedRadioBKColor = secondaryColor;
  static const Color cursorColor = secondaryColor;
  static const Color iconUnSelectedColor = Color(0xFF838383);
  static const Color iconButtonIconColor = primaryColor;
  static const Color iconMutedColor = Color(0xFF9E9E9E);
  static const Color drawerIconColor = Color(0xFF627D98);

  // Chat
  static const Color myMessageBKColor = Color(0xFFE2E2E2);
  static const Color otherMessageBKColor = tealSurface;

  // Badges & Labels
  static const Color expiredAdLabelColor = Color(0xFFE55A5A);

  // Shimmer
  static const Color shimmerBase = Color(0xFFEAEAEA);
  static const Color shimmerHighlight = Color(0xFFF7F7F7);
  static const Color shimmerDarkBase = Color(0xFF2A2A2A);
  static const Color shimmerDarkHighlight = Color(0xFF3A3A3A);

  // Shadows
  static const Color shadowLanguageButton = Color.fromRGBO(64, 75, 81, 0.04);
  static const Color shadowWallet = Color(0x14040F60);
  static const Color shadowMapAppbar = Color.fromRGBO(0, 0, 0, 0.09);
  static const Color cardShadowColor = Color(0x0D04060F); // 5% black
  static const Color socialButtonShadowColor = Color(0x29000000);

  // ===========================================================================
  // 7. DARK MODE PALETTE (FOR FUTURE EXPANSION)
  // ===========================================================================

  static const Color primaryDark = navyLight;
  static const Color accentDark = tealColor;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color buttonHighlightColorDark = Color(0xFF1E293B);
  static const Color buttonSplashColorDark = Color(0xFF334155);
  static const Color mDisabledColor = Color(0xFF64748B);
  static const Color greyBkColor = Color(0xFFF1F5F9);
}
