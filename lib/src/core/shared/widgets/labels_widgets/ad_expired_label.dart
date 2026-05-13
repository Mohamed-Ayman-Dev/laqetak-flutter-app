import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class AdExpiredLabel extends StatelessWidget {
  final EdgeInsets? padding;
  final double? fontSize;

  const AdExpiredLabel({super.key, this.fontSize, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(14, 3, 14, 3).r,

      decoration: BoxDecoration(
        color: AppColors.expiredAdLabelColor,
        borderRadius: BorderRadius.circular(5),
      ),

      child: Text(
        'منتهي',
        style: AppTextStyles.labelSmall.copyWith(
          color: Colors.white,
          fontSize: fontSize?.sp ?? 11.sp,
        ),
      ),
    );
  }
}
