import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIconButton extends StatelessWidget {
  final String icon;
  final double? iconSize;
  final void Function()? onTap;
  final Color? iconColor;
  final Color? disableColor;
  final double? borderRadius;
  final double width;
  final double height;

  final Color? borderColor;
  final Color? bkColor;

  const MyIconButton({
    super.key,
    required this.icon,
    this.iconSize,
    this.onTap,
    this.iconColor,
    this.width = 54,
    this.height = 48,

    this.borderColor,
    this.disableColor,
    this.bkColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bkColor ?? Colors.white,
        disabledBackgroundColor: disableColor,

        padding: EdgeInsets.zero,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 8)),
        ),
        maximumSize: Size(width.w, height.h),
        minimumSize: Size(width.w, height.h),
      ),
      child: SvgPicture.asset(
        icon,
        color: iconColor,
        width: iconSize != null ? iconSize?.w : 24.w,
        height: iconSize != null ? iconSize?.h : 24.h,
      ),
    );
  }
}
