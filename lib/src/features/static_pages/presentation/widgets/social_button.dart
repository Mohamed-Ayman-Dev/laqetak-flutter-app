import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/themes/colors.dart';

class SocialButton extends StatelessWidget {
  final String link;
  final String icon;

  const SocialButton({super.key, required this.link, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // UrlHelper.launchSocialLink(link);
      },
      splashColor: Colors.transparent,
      child: Container(
        height: 38.h,
        padding: EdgeInsets.all(10).r,
        width: 38.w,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor.withOpacity(0.2),
              offset: const Offset(0, 3),
              blurRadius: 40,
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
