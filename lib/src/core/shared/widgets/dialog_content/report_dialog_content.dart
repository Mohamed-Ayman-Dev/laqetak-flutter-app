import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/fields_widgets/custom_note_field.dart';
import 'package:invastro/src/core/themes/text_styles.dart';

import '../../../constants/svg_assets.dart';
import '../../../extension/space_extensions_helper.dart';
import '../buttons_widgets/custom_elevated_button.dart';

class ReportDialogContent extends StatelessWidget {
  const ReportDialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(27, 41, 27, 44).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'أدخل سبب الابلاغ',
              style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
            ),
            10.heightSpace,

            // ─── Subtitle ───
            CustomNoteField(hint: 'أكتب السبب'),
            24.heightSpace,

            // ─── Button ───
            CustomElevatedButton(
              text: 'إرسال',
              icon: SvgAssets.assetsSvgArrowRight,
              size: Size(163.w, 48.h),
              onPressed: () {
                DialogHelpers.showSuccessDialog(
                  title: 'تم ارسال الابلاغ بنجاح',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
