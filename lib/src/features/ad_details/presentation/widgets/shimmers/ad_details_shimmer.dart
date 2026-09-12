import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/shimmers/text_shimmer.dart';
import '../../../../../core/themes/colors.dart';

class AdDetailsDescShimmer extends StatelessWidget {
  const AdDetailsDescShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
          color: AppColors.containerBorderColor.withOpacity(0.23),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextShimmer(width: double.infinity, height: 8.h),
          TextShimmer(width: double.infinity, height: 8.h),
          TextShimmer(width: double.infinity, height: 8.h),
          TextShimmer(width: double.infinity, height: 8.h),
          TextShimmer(width: double.infinity, height: 8.h),
          TextShimmer(width: 220.w, height: 8.h, paddingUnder: 0),
        ],
      ),
    );
  }
}
