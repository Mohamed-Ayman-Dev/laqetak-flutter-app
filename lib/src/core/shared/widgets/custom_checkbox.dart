import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../themes/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final dynamic Function(bool?)? onTap;

  const CustomCheckbox({super.key, required this.isChecked, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        0.0,
      ), // Add padding to give the border space
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6), // Keep the border radius
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          4,
        ), // Clip the child to match the container's radius
        child: RoundCheckBox(
          isRound: true,
          size: 20.w,

          animationDuration: const Duration(milliseconds: 200),
          border: Border.all(width: 0, color: Colors.transparent),
          isChecked: isChecked,
          enableToggle: false,
          checkedColor: Colors.white,
          uncheckedColor: Colors.transparent,
          checkedWidget: Padding(
            padding: const EdgeInsets.all(4.0).r,
            child: SvgPicture.asset(
              SvgAssets.assetsSvgCheckDropdownIcon,
              height: 11.h,
              width: 11.w,
              color: AppColors.primaryColor,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
