import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class AdExpiredLabel extends StatelessWidget {
  const AdExpiredLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 3, 14, 3).r,

      decoration: BoxDecoration(
        color: AppColors.expiredAdLabelColor,
        borderRadius: BorderRadius.circular(5),
      ),

      child: Text(
        'منتهي',
        style: AppTextStyles.labelSmall.copyWith(
          color: Colors.white,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}
