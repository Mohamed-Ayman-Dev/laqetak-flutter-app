import 'package:flutter/material.dart';

extension ShowBottomSheet on BuildContext {
  showBottomSheet({
    required Widget child,
    Color? backgroundColor,
    BoxConstraints? constraints
  }) {
    return showModalBottomSheet(
      backgroundColor: backgroundColor,
      context: this,
      constraints:constraints ,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }

}
