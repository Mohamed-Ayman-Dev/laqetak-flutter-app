import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/features/ad_details/presentation/widgets/shimmers/ad_details_shimmer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/themes/theme.dart';

class AdDetailsDesc extends StatelessWidget {
  final String? desc;

  const AdDetailsDesc({super.key, this.desc});

  @override
  Widget build(BuildContext context) {
    return desc == null
        ? AdDetailsDescShimmer()
        : Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18).r,
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 150.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              border: Border.all(
                color: AppColors.containerBorderColor.withOpacity(0.23),
                width: 1,
              ),
            ),
            child: HtmlWidget(
              textStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.descTextColor,
                fontSize: 13.sp,
              ),
              desc!.isEmpty ? S.of(context).thereAreNoDescription : desc!,
            ),
          );
  }
}
