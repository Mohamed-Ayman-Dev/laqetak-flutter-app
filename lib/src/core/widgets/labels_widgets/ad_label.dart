import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class AdLabel extends StatelessWidget {
  final String labelText;
  final EdgeInsets? padding;
  final double? fontSize;

  const AdLabel({
    super.key,
    required this.labelText,
    this.padding,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(14, 9, 14, 7).r,

      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.8),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
      ),
      child: Text(
        labelText,
        style: AppTextStyles.labelSmall.copyWith(
          color: Colors.white,
          fontSize: fontSize?.sp ?? 12.sp,
        ),
      ),
    );
  }
}
