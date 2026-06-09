import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/shared/models/customer_model.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/custom_image.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class ChatHeaderWidget extends StatelessWidget {
  final CustomerModel? chatReceiver;

  const ChatHeaderWidget({super.key, this.chatReceiver});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        8.widthSpace,
        CustomImage(
          imageUrl: chatReceiver?.avatar ?? '',
          borderRadius: 100,
          height: 45,
          width: 45,
        ),
        8.widthSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تتحدث إلى',
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.bodyChatTextColor,
                fontSize: 10.sp,
              ),
            ),
            5.heightSpace,
            Text(chatReceiver?.name ?? '', style: AppTextStyles.labelMedium),
          ],
        ),
      ],
    );
  }
}
