import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';
import '../custom_Text.dart';

class AppFilterButton extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  const AppFilterButton({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelected,
  });

  @override
  State<AppFilterButton> createState() => _AppFilterButtonState();
}

class _AppFilterButtonState extends State<AppFilterButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 170),
        curve: Curves.easeIn,
        alignment: Alignment.center,

        padding: const EdgeInsets.symmetric(horizontal: 16).r,
        decoration: BoxDecoration(
          color: widget.isSelected ? AppColors.primaryColor : Colors.white,
          border: widget.isSelected
              ? null
              : Border.all(color: AppColors.inputBorderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              widget.title,
              style: widget.isSelected
                  ? AppTextStyles.filterButtonTextStyle
                  : AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
