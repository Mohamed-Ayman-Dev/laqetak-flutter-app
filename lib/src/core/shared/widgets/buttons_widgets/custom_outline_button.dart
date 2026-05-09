import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class CustomOutlineButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final Color? shadowColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? borderWidth;
  final Size? buttonSize;
  final double? elevation;
  final bool isLoading;
  final String? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? paddingInside;
  final Color? borderColor;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final OutlinedBorder? shape;
  final double? fontSize;
  final double? iconSize;

  const CustomOutlineButton({
    super.key,
    this.onPressed,
    this.child,
    this.text,
    this.shadowColor,
    this.backgroundColor,
    this.borderRadius,
    this.paddingInside,
    this.borderColor,
    this.textStyle,
    this.style,
    this.shape,
    this.borderWidth,
    this.buttonSize,
    this.elevation,
    this.isLoading = false,
    this.icon,
    this.iconColor,
    this.fontSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style:
          style ??
          ButtonStyle(
            elevation: WidgetStatePropertyAll(elevation),

            shadowColor: shadowColor == null
                ? null
                : WidgetStatePropertyAll(shadowColor),
            minimumSize: buttonSize == null
                ? null
                : WidgetStatePropertyAll(buttonSize),
            maximumSize: buttonSize == null
                ? null
                : WidgetStatePropertyAll(buttonSize),
            backgroundColor: backgroundColor == null
                ? null
                : WidgetStatePropertyAll(backgroundColor),
            padding: paddingInside == null
                ? const WidgetStatePropertyAll(EdgeInsets.zero)
                : WidgetStatePropertyAll(paddingInside),
            shape: shape == null
                ? borderRadius == null
                      ? null
                      : MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius!),
                          ),
                        )
                : WidgetStatePropertyAll(shape),
            side: borderColor == null
                ? null
                : MaterialStatePropertyAll(
                    borderWidth == null
                        ? BorderSide(color: borderColor!)
                        : BorderSide(color: borderColor!, width: borderWidth!),
                  ),
          ),
      onPressed: onPressed,
      child: isLoading
          ? CupertinoActivityIndicator()
          : child ??
                (icon != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(flex: 3),

                          SvgPicture.asset(
                            icon!,
                            width: iconSize?.sp ?? 16.sp,
                            height: iconSize?.sp ?? 16.sp,
                            color: iconColor,
                          ),

                          Spacer(),
                          Text(
                            text ?? '',
                            style:
                                textStyle ??
                                AppTextStyles.buttonsTextStyle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: fontSize?.sp,
                                ),
                          ),
                          Spacer(flex: 3),
                        ],
                      )
                    : Text(
                        text ?? '',
                        style:
                            textStyle ??
                            AppTextStyles.buttonsTextStyle.copyWith(
                              color: borderColor ?? AppColors.primaryColor,
                              fontSize: fontSize?.sp,
                            ),
                      )),
    );
  }
}
