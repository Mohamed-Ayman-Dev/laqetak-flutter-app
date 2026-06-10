import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/extension/space_extensions_helper.dart';
import 'package:invastro/src/core/shared/models/customer_model.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import 'package:invastro/src/core/shared/widgets/custom_image.dart';
import 'package:invastro/src/core/themes/text_styles.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/seller_profile_screen.dart';
import 'package:invastro/src/features/chat/presentation/screens/chat_screen.dart';

import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import '../../../../core/themes/theme.dart';

class AdDetailsSeller extends StatelessWidget {
  final CustomerModel? customer;
  final String? phone;

  const AdDetailsSeller({super.key, this.customer, this.phone});

  @override
  Widget build(BuildContext context) {
    bool isMe = customer?.id == LocatorService.auth.user?.id;
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
                arguments: customer,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                6.widthSpace,
                CustomImage(
                  imageUrl: customer?.avatar ?? '',
                  height: 39,
                  width: 39,
                  borderRadius: 100,
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
                      customer?.name ?? '',
                      style: AppTextStyles.labelSmall.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          13.heightSpace,
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: Container(
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
                    phone ?? '',
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
          ),
          if (!isMe) Divider(height: 30.h),
          if (!isMe)
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
                      arguments: {'receiver': customer},
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
                    DialogHelpers.showReportDialog(
                      customer?.id ?? 0,
                      isCustomerReport: true,
                    );
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
