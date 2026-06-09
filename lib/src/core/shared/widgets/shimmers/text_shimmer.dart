import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shimmer_wrapper.dart';

class TextShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final double? paddingUnder;
  final double? paddingRight;
  final double? paddingLeft;
  final double? paddingTop;

  const TextShimmer({
    super.key,
    this.width,
    this.height,
    this.paddingUnder,
    this.paddingRight,
    this.paddingLeft,
    this.paddingTop,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWrapper(
      child: Container(
        width: width ?? double.infinity,
        margin: EdgeInsets.only(
          top: paddingTop ?? 2,
          bottom: paddingUnder ?? 2,
          right: paddingRight ?? 0,
          left: paddingLeft ?? 0,
        ).r,
        height: height?.h ?? 7.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
