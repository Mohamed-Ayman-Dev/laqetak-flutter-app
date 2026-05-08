import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  final int value;
  final int groupValue;
  final void Function(int) onChanged;

  bool get _isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 20.w,
        height: 20.h,
        padding: const EdgeInsets.all(2).r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            width: _isSelected ? 8.r : 1.r, // ← 8px selected, 1px unselected
            color: _isSelected
                ? AppColors
                      .selectedRadioBKColor // ← gold
                : AppColors.unSelectedRadioBKColor, // ← Neutral-04
          ),
        ),
      ),
    );
  }
}
