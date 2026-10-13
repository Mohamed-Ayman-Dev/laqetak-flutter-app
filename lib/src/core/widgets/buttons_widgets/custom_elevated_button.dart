import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/widgets/custom_direction_widget.dart';

import '../../extension/space_extensions_helper.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.borderRadius = 12,
    this.size,
    this.borderColor,
    this.icon,
    this.iconSize = 20,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
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
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        disabledBackgroundColor: AppColors.disabledButtonColorBk,
        foregroundColor: foregroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius).r,
          side: borderColor != null
              ? BorderSide(color: borderColor!)
              : BorderSide.none,
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
                        CustomDirectionWidget(
                          child: SvgPicture.asset(
                            icon!,
                            width: iconSize,
                            height: iconSize,
                            colorFilter: backgroundColor == null
                                ? const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          ),
                        ),
                        8.widthSpace,
                      ],
                      Text(
                        text ?? '',
                        style: (textStyle ?? AppTextStyles.buttonsTextStyle)
                            .copyWith(
                              color:
                                  textStyle?.color ??
                                  (isDisabled
                                      ? Colors.grey[400]
                                      : backgroundColor == null
                                      ? Colors.white
                                      : AppColors.buttonTextColor),
                            ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
