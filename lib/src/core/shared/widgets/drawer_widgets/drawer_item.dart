import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';

import '../../../themes/colors.dart';
import '../../../themes/text_styles.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final String image;
  final double size;

  const DrawerItem({
    super.key,
    required this.title,
    this.onTap,
    required this.image,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image.contains('png')
                ? Image.asset(
                    image,
                    width: size.w,
                    height: size.h,
                    color: AppColors.drawerIconColor,
                  )
                : SvgPicture.asset(image, width: size.w, height: size.h),
            14.widthSpace,
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
