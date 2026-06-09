import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import '../../../../../core/shared/widgets/shimmer_wrapper.dart';
import '../../../../../core/shared/widgets/shimmers/text_shimmer.dart';

class ConversationItemShimmer extends StatelessWidget {
  const ConversationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: const Alignment(0.9, -1.4),
            children: [
              ShimmerWrapper(
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),

          10.widthSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: TextShimmer(width: 120, height: 12)),

                    8.widthSpace,

                    TextShimmer(width: 45, height: 12, paddingUnder: 0),
                  ],
                ),

                5.heightSpace,

                TextShimmer(width: double.infinity, height: 8),

                TextShimmer(width: 180, height: 8, paddingUnder: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
