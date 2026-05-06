import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  final Widget child;
  const ShimmerWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: Intl.getCurrentLocale() == 'ar'
          ? ShimmerDirection.rtl
          : ShimmerDirection.ltr,
      baseColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900]!
          : Colors.grey[300]!,
      highlightColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]!
          : Colors.grey[100]!,
      child: child,
    );
  }
}
