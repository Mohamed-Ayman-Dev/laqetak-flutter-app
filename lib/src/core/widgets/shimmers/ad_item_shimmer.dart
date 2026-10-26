import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extension/space_extensions_helper.dart';
import 'shimmer_wrapper.dart';
import 'text_shimmer.dart';
import '../../themes/colors.dart';

class AdItemShimmer extends StatelessWidget {
  final bool hideDivider;
  final bool isMyAd;

  const AdItemShimmer({
    super.key,
    this.hideDivider = false,
    this.isMyAd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: hideDivider ? 0 : 12.h),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.inputBorderColor),
        ),
        child: Row(
          children: [
            ShimmerWrapper(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 108.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 6).r,
                    height: 24.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),

            12.widthSpace,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextShimmer(width: 140.w, height: 12.h),
                      ),

                      Container(
                        height: 24.h,
                        width: 24.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),

                      if (isMyAd) 8.widthSpace,

                      if (isMyAd)
                        Container(
                          height: 24.h,
                          width: 24.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),

                  9.heightSpace,

                  Row(
                    children: [
                      Expanded(
                        child: TextShimmer(width: 100.w, height: 8.h),
                      ),

                      if (isMyAd)
                        TextShimmer(width: 40.w, height: 8.h, paddingUnder: 0),
                    ],
                  ),

                  8.heightSpace,

                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextShimmer(width: 90.w, height: 8.h),

                            TextShimmer(
                              width: 70.w,
                              height: 8.h,
                              paddingUnder: 0,
                            ),
                          ],
                        ),
                      ),

                      5.widthSpace,

                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextShimmer(width: 60.w, height: 8.h),

                            Row(
                              children: [
                                TextShimmer(
                                  width: 50.w,
                                  height: 10.h,
                                  paddingUnder: 0,
                                ),

                                7.widthSpace,

                                Container(
                                  width: 12.w,
                                  height: 12.h,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
