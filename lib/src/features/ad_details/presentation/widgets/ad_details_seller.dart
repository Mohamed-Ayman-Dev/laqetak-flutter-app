import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/images_assets.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/extension/space_extensions_helper.dart';
import 'package:laqetak/src/core/themes/text_styles.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/app_elevated_button.dart';
import 'package:laqetak/src/core/widgets/custom_image.dart';
import 'package:laqetak/src/features/ad_details/presentation/cubit/ad_details_cubit.dart';
import 'package:laqetak/src/features/ad_details/presentation/cubit/ad_details_state.dart';
import 'package:laqetak/src/features/ad_details/presentation/screens/seller_profile_screen.dart';
import 'package:laqetak/src/features/chat/presentation/screens/chat_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/helpers/bottom_helpers.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/helpers/urlHelper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/customer_model.dart';
import '../../../../core/themes/theme.dart';
import '../../../../core/widgets/buttons_widgets/app_outline_button.dart';
import '../../../../core/widgets/custom_switch.dart';
import '../../../home/presentation/cubit/ads_cubit.dart';
import '../../../home/presentation/cubit/ads_state.dart';

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
    bool isMe =
        (customer?.id == LocatorService.authCubit.state.user?.id) || isMyAd;
    return MultiBlocListener(
      listeners: [
        BlocListener<AdDetailsCubit, AdDetailsState>(
          listenWhen: (previous, current) =>
              previous.hidePhoneEventId != current.hidePhoneEventId,
          listener: (context, state) {
            AppFeedback.showToast(
              "${state.hidePhoneEnabled ? S.current.activated : S.current.deactivated} ${S.current.phoneNumberHiddenSuccessfully} ",
            );
          },
        ),
        BlocListener<AdDetailsCubit, AdDetailsState>(
          listenWhen: (previous, current) =>
              previous.actionErrorEventId != current.actionErrorEventId,
          listener: (context, state) {
            AppFeedback.errorMessage(state.errorMessage);
          },
        ),
      ],
      child: Container(
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
                    BlocSelector<AdsCubit, AdsState, AdModel?>(
                      selector: (state) => state.adDetails[ad?.id],
                      builder: (context, updatedAdDetail) {
                        return CustomSwitch(
                          value: updatedAdDetail?.hidePhone == 1,
                          onChanged: (val) {
                            context.read<AdDetailsCubit>().toggleHidePhone(
                              updatedAdDetail ?? ad ?? AdModel(),
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
            if (!isExpired) 13.heightSpace,
            if (!isExpired)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0).r,
                child: BlocSelector<AdDetailsCubit, AdDetailsState, bool>(
                  selector: (state) =>
                      state.phoneRequestStatus == RequestStatus.loading,
                  builder: (context, loadingRequestPhone) {
                    bool showNumber =
                        (isMe ||
                        !hidePhone ||
                        (ad?.contactRequestStatus == 'approved'));
                    return AppElevatedButton(
                      onPressed: (!isAuth)
                          ? () {
                              BottomHelpers.showGuestBottomSheet(context);
                            }
                          : showNumber
                          ? () {
                              if (phone != null && phone!.isNotEmpty) {
                                UrlHelper.openDialer(phone!);
                              }
                            }
                          : (ad?.contactRequestStatus == 'pending')
                          ? null
                          : () {
                              context
                                  .read<AdDetailsCubit>()
                                  .sendShowPhoneRequest(ad ?? AdModel());
                            },

                      backgroundColor: AppColors.sellerNumberBKColor
                          .withOpacity(0.5),
                      foregroundColor: Colors.transparent,
                      borderRadius: 10,
                      borderColor:
                          (showNumber ||
                              (ad?.contactRequestStatus == 'pending'))
                          ? null
                          : AppColors.primaryColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: loadingRequestPhone ? 9 : 14,
                          horizontal: 18,
                        ).r,
                        child: loadingRequestPhone
                            ? SpinKitDoubleBounce(color: AppColors.primaryColor)
                            : showNumber
                            ? Row(
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
                              )
                            : (ad?.contactRequestStatus == 'pending')
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImagesAssets.assetsImagesTimeWaiting,
                                    height: 18.h,
                                    width: 18.w,
                                    color: AppColors.primaryColor,
                                  ),
                                  10.widthSpace,
                                  Text(
                                    S.of(context).waitingForRequestApproval,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      fontSize: 13.sp,

                                      color: AppColors.numberLabelTextColor,
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).requestToShowNumber,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      fontSize: 13.sp,
                                      color: AppColors.numberLabelTextColor,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ),
            if (!isMe) Divider(height: 30.h),
            if (!isMe)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isExpired)
                    AppElevatedButton(
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
                  AppOutlineButton(
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
      ),
    );
  }
}
