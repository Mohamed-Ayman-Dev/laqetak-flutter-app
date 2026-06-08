import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../themes/colors.dart';

class UnreadMessagesCounter extends StatelessWidget {
  final num? messageCount;

  const UnreadMessagesCounter({super.key, this.messageCount});

  @override
  Widget build(BuildContext context) {
    bool hide = messageCount == null || messageCount == 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastLinearToSlowEaseIn,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      padding: hide ? EdgeInsets.zero : const EdgeInsets.all(4).r,
      child: hide
          ? null
          : Text(
              '2',
              style: AppTextStyles.labelMedium.copyWith(
                fontSize: 10.sp,
                color: Colors.white,
              ),
            ),
    );
  }
}
