import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extension/space_extensions_helper.dart';
import '../../../../../core/widgets/shimmers/shimmer_wrapper.dart';
import '../../../../../core/widgets/shimmers/text_shimmer.dart';
import '../../../../../core/themes/colors.dart';

class MessageItemShimmer extends StatelessWidget {
  final bool isMine;

  const MessageItemShimmer({super.key, this.isMine = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ShimmerWrapper(
            child: Container(
              constraints: BoxConstraints(maxWidth: 260.w, minWidth: 120.w),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8).r,
              decoration: BoxDecoration(
                color: AppColors.myMessageBKColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(isMine ? 0 : 12),
                  topLeft: Radius.circular(isMine ? 12 : 0),
                  bottomLeft: const Radius.circular(12),
                  bottomRight: const Radius.circular(12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextShimmer(width: 180, height: 8),
                  TextShimmer(width: 140, height: 8, paddingUnder: 0),
                ],
              ),
            ),
          ),

          4.heightSpace,

          TextShimmer(width: 55.w, height: 6.h, paddingUnder: 0),
        ],
      ),
    );
  }
}

class MessageImageShimmer extends StatelessWidget {
  final bool isMine;

  const MessageImageShimmer({super.key, this.isMine = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          ShimmerWrapper(
            child: Container(
              width: 140.w,
              height: 137.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          4.heightSpace,

          TextShimmer(width: 55.w, height: 6.h, paddingUnder: 0),
        ],
      ),
    );
  }
}
