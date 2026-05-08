import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final bool underline;
  final FontWeight? fontWeight;
  final void Function()? onPressed;
  final Widget? child;
  final double? width;

  const CustomTextButton({
    super.key,
    this.text,
    this.onPressed,
    this.textColor,
    this.underline = false,
    this.fontWeight,
    this.child,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      width: width?.w,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 5).r,
          ),
        ),
        child:
            child ??
            Stack(
              children: [
                Text(
                  text ?? '',
                  style: AppTextStyles.labelSmall.copyWith(color: textColor),
                ),
                if (underline)
                  Positioned(
                    bottom: 4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1,
                      color: textColor ?? AppColors.labelTextColor,
                    ),
                  ),
              ],
            ),
      ),
    );
  }
}
