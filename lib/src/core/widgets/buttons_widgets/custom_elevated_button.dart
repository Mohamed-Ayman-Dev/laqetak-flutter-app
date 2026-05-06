import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/themes/colors.dart';
import '../../../config/themes/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final String? icon;
  final Color? shadowColor;
  final Color? backgroundColor;
  final Color? iconColor;
  final bool isLoading;
  final double? borderRadius;
  final double? borderWidth;
  final Size? size;
  final double? elevation;
  final EdgeInsetsGeometry? paddingInside;
  final Color? borderColor;
  final TextStyle? textStyle;
  final ButtonStyle? style;
  final OutlinedBorder? shape;

  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.child,
    this.text,
    this.shadowColor,
    this.backgroundColor,
    this.borderRadius,
    this.paddingInside,
    this.isLoading = false,
    this.borderColor,
    this.textStyle,
    this.style,
    this.shape,
    this.borderWidth,
    this.size,
    this.elevation,
    this.icon,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          style ??
          ButtonStyle(
            elevation: WidgetStatePropertyAll(elevation),

            shadowColor: shadowColor == null
                ? null
                : WidgetStatePropertyAll(shadowColor),
            minimumSize: size == null ? null : WidgetStatePropertyAll(size),
            maximumSize: size == null ? null : WidgetStatePropertyAll(size),
            backgroundColor: onPressed == null
                ? WidgetStatePropertyAll(AppColors.disabledGreenColorBk)
                : backgroundColor == null
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
                          SvgPicture.asset(
                            icon!,
                            width: 18.sp,
                            height: 18.sp,
                            color: iconColor,
                          ),

                          Spacer(),
                          Text(
                            text ?? '',
                            style:
                                textStyle ??
                                AppTextStyles.buttonsTextStyle.copyWith(
                                  color: onPressed == null
                                      ? AppColors.hintColor
                                      : null,
                                ),
                          ),
                          Spacer(),
                        ],
                      )
                    : Text(
                        text ?? '',
                        style:
                            textStyle ??
                            AppTextStyles.buttonsTextStyle.copyWith(
                              color: onPressed == null
                                  ? AppColors.hintColor
                                  : null,
                            ),
                      )),
    );
  }
}
