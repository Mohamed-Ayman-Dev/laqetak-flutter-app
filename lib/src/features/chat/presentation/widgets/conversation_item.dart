import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/widgets/custom_image.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/unread_messages_counter.dart';
import '../../../../core/themes/colors.dart';

class ConversationItem extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String image;
  final bool messageCount;

  const ConversationItem({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.image,
    this.messageCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5).r,

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
        CustomImage(
          imageUrl: '',
          placeholder: image,
          width: 45.w,
          height: 45.h,
          borderRadius: 100,
        ),
        if (messageCount) UnreadMessagesCounter(),
      ],
    );
  }
}
