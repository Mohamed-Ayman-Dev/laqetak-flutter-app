import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/images_assets.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/custom_image.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class ChatHeaderWidget extends StatelessWidget {
  const ChatHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        8.widthSpace,

        CustomImage(
          imageUrl: '',
          borderRadius: 100,
          height: 45,
          width: 45,
          placeholder: ImagesAssets.assetsImagesMockPersonImage2,
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
            Text('محمود عبد الله', style: AppTextStyles.labelMedium),
          ],
        ),
      ],
    );
  }
}
