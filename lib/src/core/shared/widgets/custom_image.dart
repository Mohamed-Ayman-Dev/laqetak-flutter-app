import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/shared/widgets/shimmer_wrapper.dart';

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

        // placeholder: showLoading
        //     ? (context, url) => Container(
        //         height: height.h,
        //         width: width.w,
        //         color: Colors.grey[200],
        //         child: const Center(child: AppLoadingIndicator()),
        //       )
        //     : null,
        placeholder: showLoading
            ? (context, url) => ShimmerWrapper(
                child: Container(
                  height: height.h,
                  width: width.w,
                  color: Colors.grey.shade200,
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
