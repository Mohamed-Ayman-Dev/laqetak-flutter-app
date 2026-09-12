import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../extension/space_extensions_helper.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.isLoading = false,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 35,
    this.size,
    this.borderColor,
    this.borderWidth = 1,
    this.icon,
    this.iconSize = 20,
    this.iconColor,
    this.fontSize,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final bool isLoading;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final Size? size;
  final Color? borderColor;
  final double borderWidth;
  final String? icon;
  final double iconSize;
  final Color? iconColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: size,
        maximumSize: size,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledBackgroundColor: AppColors.disabledButtonColorBk,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius).r,
        ),
        side: BorderSide(
          color: isDisabled
              ? AppColors.disabledButtonColorBk
              : borderColor ?? AppColors.primaryColor,
          width: borderWidth,
        ),
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
                          colorFilter: iconColor != null
                              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                              : null,
                        ),
                        8.widthSpace,
                      ],
                      Text(
                        text ?? '',
                        style:
                            textStyle ??
                            AppTextStyles.buttonsTextStyle.copyWith(
                              color: isDisabled
                                  ? Colors.grey[400]
                                  : borderColor ?? AppColors.primaryColor,
                              fontSize: fontSize,
                            ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
