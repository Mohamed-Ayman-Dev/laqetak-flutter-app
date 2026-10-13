import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';
import '../custom_Text.dart';

class FilterButton extends StatefulWidget {
  final String title;
  final void Function()? onTap;
  final bool isSelected;

  const FilterButton({
    super.key,
    required this.title,
    this.onTap,
    required this.isSelected,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
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
