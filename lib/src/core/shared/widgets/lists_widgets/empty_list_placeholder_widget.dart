import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyListPlaceholderWidget extends StatelessWidget {
  final String? text;
  final double? paddingTop;
  final double? paddingBottom;
  final TextStyle? style;

  const EmptyListPlaceholderWidget({
    super.key,
    this.text,
    this.paddingTop,
    this.paddingBottom,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop ?? 260,
          bottom: paddingBottom ?? 0,
          left: 50,
          right: 50,
        ).r,
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: style ?? TextStyle(color: Colors.black54, fontSize: 16.sp),
        ),
      ),
    );
  }
}
