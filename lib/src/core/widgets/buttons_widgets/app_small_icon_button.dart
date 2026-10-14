import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSmallIconButton extends StatelessWidget {
  final String icon;
  final void Function() onTab;
  final double width;

  final double height;

  const AppSmallIconButton({
    super.key,
    required this.icon,
    required this.onTab,
    this.height = 24,
    this.width = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.all(8.0).r,
        child: SvgPicture.asset(icon, width: width.w, height: height.h),
      ),
    );
  }
}
