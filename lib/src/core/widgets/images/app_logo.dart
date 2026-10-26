import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final String? tag;
  final BoxFit? fit;
  final String? logo;

  const AppLogo({
    super.key,
    this.height,
    this.width,
    this.tag,
    this.fit,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? 'logo',
      child: Image.asset(
        logo ?? ImagesAssets.assetsImagesLogo,
        fit: fit ?? BoxFit.cover,
        width: width ?? 289.w,
        height: height ?? 52.h,
      ),
    );
  }
}
