import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/features/home/presentation/screens/home_layout_screen.dart';

import '../../../../generated/l10n.dart';
import '../../constants/svg_assets.dart';
import '../../extension/space_extensions_helper.dart';
import '../buttons_widgets/custom_elevated_button.dart';

class YesNoDialogContent extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? buttonText;
  final void Function()? onButtonTap;

  const YesNoDialogContent({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 250.w),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(34, 31, 34, 36).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(6).r,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        offset: Offset(0, 1),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    SvgAssets.assetsSvgCloseDrawerIcon,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ),
            9.heightSpace,
            // ─── Title ───
            Text(
              title,
              style: AppTextStyles.labelSmall.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            25.heightSpace,

            // ─── Subtitle ───
            if (subtitle != null)
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
              ),
            35.heightSpace,

            // ─── Button ───
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: buttonText ?? S.of(context).confirm,
                    onPressed: onButtonTap != null
                        ? () {
                            onButtonTap!();
                          }
                        : () {
                            LocatorService.navigationService.currentState
                                ?.popUntil(
                                  (route) =>
                                      route.settings.name ==
                                      HomeLayoutScreen.routeName,
                                );
                          },
                  ),
                ),
                11.widthSpace,
                Expanded(
                  child: CustomOutlineButton(
                    text: S.of(context).cancel,
                    borderRadius: 8,
                    borderColor: AppColors.reportBorderColor,

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
