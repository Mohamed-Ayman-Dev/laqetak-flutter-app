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
import 'package:invastro/src/features/ad_details/presentation/controllers/ad_details_controller.dart';
import 'package:invastro/src/features/ad_details/presentation/screens/seller_profile_screen.dart';
import 'package:invastro/src/features/chat/presentation/screens/chat_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/helpers/urlHelper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import '../../../../core/shared/widgets/custom_switch.dart';
import '../../../../core/themes/theme.dart';
import '../../../home/presentation/providers/ads.dart';

class AdDetailsSeller extends StatelessWidget {
  final CustomerModel? customer;
  final String? phone;
  final bool hidePhone;
  final bool isMyAd;
  final bool isExpired;

  final AdModel? ad;

  const AdDetailsSeller({
    super.key,
    this.customer,
    this.phone,
    this.isMyAd = false,
    this.hidePhone = false,
    this.isExpired = false,
    this.ad,
  });

  @override
  Widget build(BuildContext context) {
    bool isMe = (customer?.id == LocatorService.auth.user?.id) || isMyAd;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 10).r,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).advertiser,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 10.sp,
                          color: AppColors.sellerLabelTextColor,
                        ),
                      ),
                      Text(
                        customer?.name ?? '',
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isMe && !isExpired)
                  Selector<Ads, AdModel?>(
                    selector: (context, provider) =>
                        provider.myAdDetails[ad?.id],
                    shouldRebuild: (previous, next) => true,
                    builder: (context, updatedAdDetail, child) {
                      return CustomSwitch(
                        value: updatedAdDetail?.hidePhone == 1,
                        onChanged: (val) {
                          AdDetailsController.toggleHidePhone(
                            ad: ad ?? AdModel(),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
          if (!isExpired) 13.heightSpace,
          if ((isMe || !hidePhone) && !isExpired)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                if (phone != null && phone!.isNotEmpty) {
                  UrlHelper.openDialer(phone!);
                }
              },
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
                      S.of(context).contactNumber,
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
                if (!isExpired)
                  CustomElevatedButton(
                    text: S.of(context).chat,
                    textStyle: AppTextStyles.labelLarge.copyWith(
                      fontSize: 12.sp,
                    ),
                    borderRadius: 35,
                    icon: SvgAssets.assetsSvgChatIcon,
                    size: Size(97.w, 36.h),
                    borderColor: AppColors.reportBorderColor,
                    onPressed: () {
                      isAuth
                          ? LocatorService.navigationService.currentState
                                ?.pushNamed(
                                  ChatScreen.routeName,
                                  arguments: {'receiver': customer},
                                )
                          : BottomHelpers.showGuestBottomSheet(context);
                      ;
                    },
                  ),
                if (!isExpired) 7.widthSpace,
                CustomOutlineButton(
                  text: S.of(context).report,
                  textStyle: AppTextStyles.buttonsTextStyle.copyWith(
                    color: AppColors.labelTextColor,
                    fontSize: 12.sp,
                  ),
                  size: Size(97.w, 36.h),
                  borderColor: AppColors.reportBorderColor,
                  onPressed: () {
                    isAuth
                        ? DialogHelpers.showReportDialog(
                            customer?.id ?? 0,
                            isCustomerReport: true,
                          )
                        : BottomHelpers.showGuestBottomSheet(context);
                    ;
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
