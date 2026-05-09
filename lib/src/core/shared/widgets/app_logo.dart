import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  final double? width;
  final String? tag;
  final BoxFit? fit;

  const AppLogo({super.key, this.height, this.width, this.tag, this.fit});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag ?? 'logo',
      child: Image.asset(
        ImagesAssets.assetsImagesLogo,
        fit: fit ?? BoxFit.cover,
        width: width ?? 289.w,
        height: height ?? 52.h,
      ),
    );
  }
}
