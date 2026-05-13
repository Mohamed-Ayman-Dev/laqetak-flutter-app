import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../../core/themes/theme.dart';

class AdDetailsDesc extends StatelessWidget {
  const AdDetailsDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
          color: AppColors.containerBorderColor.withOpacity(0.23),
          width: 1,
        ),
      ),
      child: Text(
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.descTextColor,
          fontSize: 13.sp,
        ),
        'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام ',
      ),
    );
  }
}
