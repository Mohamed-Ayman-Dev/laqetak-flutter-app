import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/home/presentation/screens/home_layout_screen.dart';

import '../../../constants/svg_assets.dart';
import '../../../extension/space_extensions_helper.dart';
import '../buttons_widgets/custom_elevated_button.dart';

class SuccessDialogContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonText;
  final void Function()? onButtonTap;

  const SuccessDialogContent({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 270, maxWidth: 320).r,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(34, 31, 34, 36).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Check Icon ───
            Image.asset(
              ImagesAssets.assetsImagesCheckRingRound,

              height: 112.h,
              width: 112.w,
            ),
            24.heightSpace,

            // ─── Title ───
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.labelSmall.copyWith(fontSize: 20.sp),
            ),
            10.heightSpace,

            // ─── Subtitle ───
            if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelLarge.copyWith(fontSize: 15.sp),
              ),
            24.heightSpace,

            // ─── Button ───
            CustomElevatedButton(
              text: buttonText ?? 'الرئيسية',
              icon: SvgAssets.assetsSvgArrowRight,
              size: Size(163.w, 48.h),
              onPressed: onButtonTap != null
                  ? () {
                      onButtonTap!();
                    }
                  : () {
                      LocatorService.navigationService.currentState?.popUntil(
                        (route) =>
                            route.settings.name == HomeLayoutScreen.routeName,
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
