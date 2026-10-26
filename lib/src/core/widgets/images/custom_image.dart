import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/shimmers/shimmer_wrapper.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholder;
  final bool showLoading;
  final double borderRadius;
  final double width;
  final double height;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.showLoading = true,
    this.borderRadius = 10,
    this.width = 133,
    this.height = 108,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height.h,
        width: width.w,
        fit: BoxFit.cover,
        placeholder: showLoading
            ? (context, url) => ShimmerWrapper(
                child: Container(
                  height: height.h,
                  width: width.w,
                  color: AppColors.imagePlaceholderBKColor,
                ),
              )
            : null,
        errorWidget: (context, url, error) => Container(
          height: height.h,
          width: width.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: DecorationImage(
              image: AssetImage(
                placeholder ?? ImagesAssets.assetsImagesImagePlaceholder,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
