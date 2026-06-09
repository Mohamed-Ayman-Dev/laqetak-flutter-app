import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/string_manager.dart';

class ShimmerWrapper extends StatelessWidget {
  final Widget child;

  const ShimmerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: Intl.getCurrentLocale() == StringManager.arLanguageCode
          ? ShimmerDirection.rtl
          : ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1400),
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF2A2A2A)
          : const Color(0xFFEAEAEA),
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF3A3A3A)
          : const Color(0xFFF7F7F7),
      child: child,
    );
  }
}
