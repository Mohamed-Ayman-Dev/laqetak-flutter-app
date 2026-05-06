import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final String? tag;
  final BoxFit? fit;

  const AppLogo({super.key, this.height, this.width, this.tag, this.fit});

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Hero(
      tag: tag ?? 'logo',
      child: Image.asset(
        'assets/images/logo.png',
        fit: fit ?? BoxFit.cover,
        width: width ?? (isTablet ? 120.w : 163.w),
        height: height ?? (isTablet ? 200.h : 171.h),
      ),
    );
  }
}
