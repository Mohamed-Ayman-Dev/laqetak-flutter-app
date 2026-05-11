import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../themes/colors.dart';

class UnreadMessagesCounter extends StatelessWidget {
  const UnreadMessagesCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      padding: const EdgeInsets.all(4).r,
      child: Text(
        '2',
        style: AppTextStyles.labelMedium.copyWith(
          fontSize: 10.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
