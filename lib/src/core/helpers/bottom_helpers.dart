import 'package:flutter/material.dart';

import '../widgets/bottom_sheet_content/guest_bottom_sheet.dart';
import '../widgets/bottom_sheet_content/language_bottom.dart';

class BottomHelpers {
  static void showLanguageBottomSheet(
    BuildContext context, {
    bool showSplash = true,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return LanguageBottom(showSplash: showSplash);
      },
    );
  }

  static Future<void> showGuestBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return GuestBottom();
      },
    );
  }
}
