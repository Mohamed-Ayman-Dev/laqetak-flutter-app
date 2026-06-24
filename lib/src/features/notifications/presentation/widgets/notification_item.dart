import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../core/constants/svg_assets.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/notify_circle.dart';
import '../../../../core/themes/colors.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final bool isSeen;
  final bool messageCount;

  const NotificationItem({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    this.isSeen = false,
    this.messageCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15).r,

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildIcon(),
          10.widthSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: AppTextStyles.labelLarge),
                    ),
                    2.widthSpace,
                    Text(
                      date,
                      style: AppTextStyles.bodySmall.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.dateTextColor,
                      ),
                    ),
                  ],
                ),
                5.heightSpace,
                Text(
                  desc,
                  style: AppTextStyles.bodySmall.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIcon() {
    return Stack(
      alignment: const Alignment(0.9, -1.4),
      children: [
        Container(
          padding: EdgeInsets.all(10).r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.notificationBorderColor),
          ),
          child: Stack(
            alignment: const Alignment(0.9, -1),
            children: [
              SvgPicture.asset(
                SvgAssets.assetsSvgNotificationIconUnselected,
                color: AppColors.notificationBorderColor,
                height: 24.h,
                width: 24.w,
              ),
              NotifyCircle(showNotify: !isSeen),
            ],
          ),
        ),
        // if (messageCount) UnreadMessagesCounter(),
      ],
    );
  }
}
