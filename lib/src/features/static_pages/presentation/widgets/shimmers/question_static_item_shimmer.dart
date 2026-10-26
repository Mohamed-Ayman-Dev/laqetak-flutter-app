import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import '../../../../../core/widgets/shimmers/shimmer_wrapper.dart';
import '../../../../../core/widgets/shimmers/text_shimmer.dart';
import '../../../../../core/themes/colors.dart';

class QuestionStaticItemShimmer extends StatelessWidget {
  const QuestionStaticItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.questionBorderColor, width: 0.7),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      child: Row(
        children: [
          Expanded(
            child: TextShimmer(width: 180.w, height: 10.h, paddingUnder: 0),
          ),

          VerticalDivider(endIndent: 10.h, indent: 10.h),

          15.widthSpace,

          ShimmerWrapper(
            child: Container(
              width: 18.w,
              height: 18.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
