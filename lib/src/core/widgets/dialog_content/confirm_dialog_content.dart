import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';
import '../../extension/space_extensions_helper.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';
import '../buttons_widgets/app_elevated_button.dart';
import '../buttons_widgets/app_outline_button.dart';
import '../custom_Text.dart';

class ConfirmDialogContent extends StatelessWidget {
  final String title;
  final String description;
  final String yesText;
  final Color? yesColor;
  final void Function() onYes;

  const ConfirmDialogContent({
    super.key,
    required this.title,
    required this.description,
    required this.yesText,
    required this.onYes,
    this.yesColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 500.h),
        Container(
          width: 340.w, // Adjust width here
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 24,
            top: 24,
          ).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              description == '' ? 10.heightSpace : 24.heightSpace,
              if (description != '')
                CustomText(
                  description,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.bodyGreyTextColor,
                  ),
                ),
              24.heightSpace,
              Row(
                children: [
                  Expanded(
                    child: AppOutlineButton(
                      size: Size(double.infinity, 45.h),
                      text: S.of(context).cancel,
                      textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                        color: Colors.black,
                      ),
                      borderRadius: 8,
                      borderColor: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  16.widthSpace,
                  Expanded(
                    child: AppElevatedButton(
                      size: Size(double.infinity, 45.h),
                      text: yesText,
                      textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                        color: Colors.white,
                      ),
                      backgroundColor: yesColor ?? AppColors.errorTextColor,
                      onPressed: onYes,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
