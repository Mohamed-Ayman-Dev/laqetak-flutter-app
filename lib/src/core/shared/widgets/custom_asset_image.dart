import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAssetImage extends StatelessWidget {
  final String image;
  final double borderRadius;
  final double width;
  final double height;

  const CustomAssetImage({
    super.key,
    required this.image,
    this.borderRadius = 10,
    this.width = 100,
    this.height = 133,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: height.h,
        width: width.w,
      ),
    );
  }
}
