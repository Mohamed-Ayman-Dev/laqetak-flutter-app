import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import '../../../../../core/widgets/shimmers/shimmer_wrapper.dart';
import '../../../../../core/themes/colors.dart';

class AdImageGalleryShimmer extends StatelessWidget {
  const AdImageGalleryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWrapper(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 237.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Positioned.directional(
                textDirection: Directionality.of(context),
                end: 22.w,
                child: Container(
                  width: 100.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              Positioned.directional(
                textDirection: Directionality.of(context),
                start: 8.w,
                bottom: 5.h,
                child: Container(
                  width: 90.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),

        11.heightSpace,

        SizedBox(
          height: 74.h,
          child: ListView.separated(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => 10.widthSpace,
            itemBuilder: (_, index) {
              return ShimmerWrapper(
                child: Container(
                  width: 106.w,
                  height: 74.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: index == 0
                          ? AppColors.primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
