import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppSvgButton extends StatelessWidget {
  const AppSvgButton({
    super.key,
    required this.icon,
    this.onTap,
    this.color,
    this.size,
    this.padding = const EdgeInsets.all(8),
    this.backgroundColor,
    this.borderRadius,
  });

  final String icon;
  final VoidCallback? onTap;
  final Color? color;
  final double? size;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: padding,
        decoration: backgroundColor == null
            ? null
            : BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
              ),
        child: SvgPicture.asset(
          icon,
          width: size?.w,
          height: size?.h,
          colorFilter: color == null
              ? null
              : ColorFilter.mode(color!, BlendMode.srcIn),
        ),
      ),
    );
  }
}
