import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/shimmer_wrapper.dart';
import '../../../../core/widgets/shimmers/text_shimmer.dart';
import '../../../../core/themes/colors.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWrapper(
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.notificationBorderColor),
              ),
            ),
          ),

          10.widthSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextShimmer(width: 140.w, height: 12.h),
                    ),

                    12.widthSpace,

                    TextShimmer(width: 50.w, height: 8.h, paddingUnder: 0),
                  ],
                ),

                5.heightSpace,

                TextShimmer(width: double.infinity, height: 8.h),

                TextShimmer(width: 180.w, height: 8.h, paddingUnder: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
