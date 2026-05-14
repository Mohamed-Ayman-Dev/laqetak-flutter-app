import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/images_assets.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/seller_profile_screen.dart';
import 'package:invastro/src/features/chat/presentation/screens/chat_screen.dart';

import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import '../../../../core/themes/theme.dart';

class AdDetailsSeller extends StatelessWidget {
  const AdDetailsSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 20).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
          color: AppColors.containerBorderColor.withOpacity(0.23),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              LocatorService.navigationService.currentState?.pushNamed(
                SellerProfileScreen.routeName,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                6.widthSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    ImagesAssets.assetsImagesMockPersonImage,
                    fit: BoxFit.cover,
                    height: 39.h,
                    width: 39.w,
                  ),
                ),
                8.widthSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المعلن',
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 10.sp,
                        color: AppColors.sellerLabelTextColor,
                      ),
                    ),
                    Text(
                      'محمد الدوسري',
                      style: AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          13.heightSpace,
          Container(
            decoration: BoxDecoration(
              color: AppColors.sellerNumberBKColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            ),

            margin: EdgeInsets.symmetric(horizontal: 6).r,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18).r,
            child: Row(
              children: [
                Text(
                  'رقم التواصل',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.numberLabelTextColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Spacer(),
                Text(
                  '0966 000 0000',
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 15.sp,
                    color: AppColors.numberLabelTextColor,
                  ),
                ),
                12.widthSpace,
                SvgPicture.asset(
                  SvgAssets.assetsSvgCall,
                  height: 18.h,
                  width: 18.w,
                ),
              ],
            ),
          ),
          Divider(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomElevatedButton(
                text: 'مراسلة',
                textStyle: AppTextStyles.labelLarge.copyWith(fontSize: 12.sp),
                borderRadius: 35,
                icon: SvgAssets.assetsSvgChatIcon,
                size: Size(97.w, 36.h),
                borderColor: AppColors.reportBorderColor,
                onPressed: () {
                  LocatorService.navigationService.currentState?.pushNamed(
                    ChatScreen.routeName,
                  );
                },
              ),
              7.widthSpace,
              CustomOutlineButton(
                text: 'الإبلاغ',
                textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                  color: AppColors.labelTextColor,
                  fontSize: 12.sp,
                ),
                size: Size(97.w, 36.h),
                borderColor: AppColors.reportBorderColor,
                onPressed: () {
                  DialogHelpers.showReportDialog();
                },
              ),
              6.widthSpace,
            ],
          ),
        ],
      ),
    );
  }
}
