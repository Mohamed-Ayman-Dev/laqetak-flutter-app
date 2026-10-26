import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/string_manager.dart';
import '../../themes/colors.dart';

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
          ? AppColors.shimmerDarkBase
          : AppColors.shimmerBase,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.shimmerDarkHighlight
          : AppColors.shimmerHighlight,
      child: child,
    );
  }
}
