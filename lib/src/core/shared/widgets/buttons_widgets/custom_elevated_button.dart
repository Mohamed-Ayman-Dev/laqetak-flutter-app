import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../extension/space_extensions_helper.dart';
import '../../../themes/colors.dart';
import '../../../themes/gradients.dart';
import '../../../themes/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.isLoading = false,
    this.gradient,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 8,
    this.size,
    this.borderColor,
    this.icon,
    this.iconSize = 20,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final bool isLoading;
  final Gradient? gradient; // ← new
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final Size? size;
  final Color? borderColor;
  final String? icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        // let Ink handle padding
        minimumSize: size,
        maximumSize: size,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledBackgroundColor: AppColors.disabledButtonColorBk,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius).r,
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
        ),
      ),
      child: Ink(
        decoration: isDisabled
            ? null
            : BoxDecoration(
                gradient: backgroundColor != null
                    ? null
                    : AppGradients.buttonGradient,
                borderRadius: BorderRadius.circular(borderRadius).r,
              ),
        child: Container(
          width: size?.width ?? double.infinity,
          height: size?.height ?? 48.h,
          alignment: Alignment.center,
          child: isLoading
              ? const CupertinoActivityIndicator()
              : child ??
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          SvgPicture.asset(
                            icon!,
                            width: iconSize,
                            height: iconSize,
                          ),
                          8.widthSpace,
                        ],
                        Text(
                          text ?? '',
                          style:
                              textStyle ??
                              AppTextStyles.buttonsTextStyle.copyWith(
                                color: isDisabled ? Colors.grey[400] : null,
                              ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
