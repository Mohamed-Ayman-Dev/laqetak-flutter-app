import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../helpers/others_helper.dart';

class CustomDirectionWidget extends StatelessWidget {
  final Widget child;

  const CustomDirectionWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: !isArabic ? Matrix4.rotationY(math.pi) : Matrix4.identity(),
      child: child,
    );
  }
}
