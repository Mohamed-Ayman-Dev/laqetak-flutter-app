import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../themes/colors.dart';

class CustomCheckbox extends StatelessWidget {
  final bool isChecked;
  final Color? selectedColor;
  final Color? unSelectedBorderColor;
  final double size;
  final dynamic Function(bool?)? onTap;

  const CustomCheckbox({
    super.key,
    required this.isChecked,
    this.unSelectedBorderColor,
    this.onTap,
    this.size = 20,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(
        0.0,
      ), // Add padding to give the border space
      decoration: BoxDecoration(
        color: (isChecked && selectedColor != null) ? selectedColor : null,
        borderRadius: BorderRadius.circular(6), // Keep the border radius
        border: Border.all(
          color: (isChecked && selectedColor != null)
              ? AppColors.primaryColor
              : unSelectedBorderColor ?? AppColors.borderColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          4,
        ), // Clip the child to match the container's radius
        child: RoundCheckBox(
          isRound: true,
          size: size.w,

          animationDuration: const Duration(milliseconds: 200),
          border: Border.all(width: 0, color: Colors.transparent),
          isChecked: isChecked,
          enableToggle: false,
          checkedColor: selectedColor ?? Colors.white,
          uncheckedColor: Colors.transparent,
          checkedWidget: Padding(
            padding: const EdgeInsets.all(4.0).r,
            child: SvgPicture.asset(
              SvgAssets.assetsSvgCheckDropdownIcon,
              height: 11.h,
              width: 11.w,
              color: (isChecked && selectedColor != null)
                  ? Colors.white
                  : AppColors.primaryColor,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
