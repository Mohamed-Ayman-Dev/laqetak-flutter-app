import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class ChatTime extends StatelessWidget {
  const ChatTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4).r,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(99),
      ),

      child: Text(
        'اليوم',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.labelTextColor,
        ),
      ),
    );
  }
}
