import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final void Function() onTab;

  const ConversationItem({
    super.key,
    required this.title,
    required this.desc,
    required this.onTab,
    required this.date,
    required this.image,
    this.messageCount = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTab,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0).r,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5).r,

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,

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
                    style: AppTextStyles.bodySmall.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.bodyChatTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Stack(
      alignment: const Alignment(0.9, -1.4),
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.conversationBorderColor),
          ),
          // child: CustomImage(
          //   imageUrl: '',
          //   placeholder: image,
          //   width: 45.w,
          //   height: 45.h,
          //   borderRadius: 100,
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 45.w,
              height: 45.h,
            ),
          ),
        ),
        if (messageCount) UnreadMessagesCounter(),
      ],
    );
  }
}
