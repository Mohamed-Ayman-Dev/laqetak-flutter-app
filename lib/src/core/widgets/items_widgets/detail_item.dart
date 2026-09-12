import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../extension/space_extensions_helper.dart';
import '../../themes/text_styles.dart';

class DetailItem extends StatelessWidget {
  final String icon;
  final String text;
  final double? iconSize;
  final int? maxLines;
  final int flex;

  const DetailItem({
    super.key,
    required this.icon,
    required this.text,
    this.maxLines,
    this.flex = 1,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,

      children: [
        SvgPicture.asset(
          icon,
          height: iconSize?.h ?? 16.h,
          width: iconSize?.w ?? 16.w,
        ),
        3.widthSpace,
        Flexible(
          flex: flex,
          child: Text(text, style: AppTextStyles.bodySmall, maxLines: maxLines),
        ),
      ],
    );
  }
}
