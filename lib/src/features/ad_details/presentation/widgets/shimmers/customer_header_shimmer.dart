import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import '../../../../../core/widgets/shimmer_wrapper.dart';
import '../../../../../core/widgets/shimmers/text_shimmer.dart';

class CustomerHeaderShimmer extends StatelessWidget {
  const CustomerHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerWrapper(
          child: Container(
            width: 122.w,
            height: 122.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),

        17.heightSpace,

        TextShimmer(width: 140.w, height: 12.h, paddingUnder: 0),

        12.heightSpace,

        TextShimmer(width: 180.w, height: 8.h, paddingUnder: 0),

        24.heightSpace,

        Row(
          children: [
            45.widthSpace,

            ShimmerWrapper(
              child: Container(
                width: 34.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            const Spacer(),

            ShimmerWrapper(
              child: Container(
                width: 34.w,
                height: 34.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),

            45.widthSpace,
          ],
        ),
      ],
    );
  }
}
