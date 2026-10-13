import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/drawer_widgets/custom_drawer.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/vat_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/others/presentation/screens/payment_webview.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_state.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../cubit/my_ads_cubit.dart';
import '../cubit/my_ads_state.dart';
import '../widgets/payment_method_item.dart';

class AddAdPayScreen extends StatefulWidget {
  static const routeName = '/add-ad-pay-screen';

  const AddAdPayScreen({super.key});

  @override
  State<AddAdPayScreen> createState() => _AddAdPayScreenState();
}

class _AddAdPayScreenState extends State<AddAdPayScreen> {
  final _formKey = GlobalKey<FormState>();

  int _selectedCard = 0;
  bool once = false;
  AdModel? ad;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args = ModalRoute.of(context)?.settings.arguments as AdModel?;
      if (args != null) {
        ad = args;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.read<SettingsCubit>().state.settings == null) {
          context.read<SettingsCubit>().getSettings();
        }
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              current.hasError && !previous.hasError,
          listener: (context, state) =>
              AppFeedback.errorMessage(state.errorMessage),
        ),
        BlocListener<MyAdsCubit, MyAdsState>(
          listenWhen: (previous, current) =>
              previous.actionStatus != current.actionStatus &&
              current.lastMutation == MyAdsMutation.pay,
          listener: (context, state) async {
            switch (state.actionStatus) {
              case RequestStatus.loading:
                AppFeedback.loadingMessage();
                return;
              case RequestStatus.error:
                AppFeedback.errorMessage(state.errorMessage);
                return;
              case RequestStatus.success:
                EasyLoading.dismiss();
              case RequestStatus.initial:
                return;
            }
            if (state.actionStatus != RequestStatus.success) return;
            if (state.checkoutUrl != null) {
              final result = await LocatorService.navigationService.currentState
                  ?.pushNamed(
                    PaymentWebView.routeName,
                    arguments: {
                      'initialUrl': state.checkoutUrl,
                      'orderId': ad?.id,
                      'time': state.paymentTime,
                    },
                  );
              if (result == true) {
                LocatorService.adsCubit.getAds(refresh: true);
                DialogHelpers.showSuccessDialog(
                  title: S.current.congratulationsPaymentCompletedSuccessfully,
                  subtitle: S.current.yourAdHasBeenPublishedSuccessfully,
                );
              } else if (result == false) {
                EasyLoading.showError(
                  S.current.paymentFailedPleaseTryAgainLater,
                  dismissOnTap: true,
                );
              }
            } else if (_selectedCard == 0) {
              LocatorService.adsCubit.getAds(refresh: true);
              DialogHelpers.showSuccessDialog(
                title: S.current.congratulationsPaymentCompletedSuccessfully,
                subtitle: S.current.yourAdHasBeenPublishedSuccessfully,
              );
            }
          },
        ),
      ],
      child: BlocSelector<SettingsCubit, SettingsState, String?>(
        selector: (state) => state.settings?.costPerAd,
        builder: (context, costPerAd) {
          return Scaffold(
            appBar: CustomAppbar(
              icons: [AppbarIcons.logo, AppbarIcons.drawer],

              flexRight: 8,
            ),
            drawer: CustomDrawer(),
            body: SafeArea(
              top: false,
              bottom: true,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 17).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      43.heightSpace,
                      DottedBorder(
                        options: RoundedRectDottedBorderOptions(
                          dashPattern: const [3, 3],
                          strokeWidth: 1,
                          color: AppColors.priceBorderColor,
                          radius: Radius.circular(10.r),
                          padding: EdgeInsets.all(1).r,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 30,
                          ).r,
                          decoration: BoxDecoration(
                            color: AppColors.searchBKColor,
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    S.of(context).adPublishingFee,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.labelBlackTextColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    costPerAd ?? '',
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.priceTextColor,
                                      height: 1.2,
                                    ),
                                  ),
                                  7.widthSpace,
                                  SvgPicture.asset(
                                    SvgAssets.assetsSvgSarIcon,
                                    color: AppColors.primaryColor,
                                    width: 10.w,
                                    height: 10.h,
                                  ),
                                ],
                              ),
                              10.heightSpace,
                              Row(
                                children: [
                                  Text(
                                    S.of(context).valueAddedTax15,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.labelBlackTextColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    VatHelper.vatAmount(
                                      double.tryParse(costPerAd ?? '') ?? 0,
                                    ).toString(),
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.priceTextColor,
                                      height: 1.2,
                                    ),
                                  ),
                                  7.widthSpace,
                                  SvgPicture.asset(
                                    SvgAssets.assetsSvgSarIcon,
                                    color: AppColors.primaryColor,
                                    width: 10.w,
                                    height: 10.h,
                                  ),
                                ],
                              ),

                              Divider(height: 30.h),
                              Row(
                                children: [
                                  Text(
                                    S.of(context).total,
                                    style: AppTextStyles.labelSmall.copyWith(
                                      color: AppColors.labelBlackTextColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    VatHelper.totalWithVat(
                                      double.tryParse(costPerAd ?? '') ?? 0,
                                    ).toString(),
                                    style: AppTextStyles.labelLarge.copyWith(
                                      color: AppColors.priceTextColor,
                                      height: 1.2,
                                    ),
                                  ),
                                  7.widthSpace,
                                  SvgPicture.asset(
                                    SvgAssets.assetsSvgSarIcon,
                                    color: AppColors.primaryColor,
                                    width: 10.w,
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      30.heightSpace,
                      Text(
                        S.of(context).selectPaymentMethod,
                        style: AppTextStyles.labelSmall.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      20.heightSpace,
                      PaymentMethodItem(
                        title: S.of(context).cash,
                        cardType: PaymentMethods.cash,
                        isSelected: _selectedCard == 0,
                        onTap: () => setState(() => _selectedCard = 0),
                      ),
                      12.heightSpace,
                      PaymentMethodItem(
                        title: S.of(context).card,
                        cardType: PaymentMethods.card,
                        isSelected: _selectedCard == 1,
                        onTap: () => setState(() => _selectedCard = 1),
                      ),
                      Expanded(child: SizedBox()),
                      // Text(
                      //   'أدخل بيانات بطاقة الدفع',
                      //   style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
                      // ),
                      // 24.heightSpace,
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30).r,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(10).r,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         'سعر العمولة',
                      //         style: AppTextStyles.labelSmall.copyWith(
                      //           color: AppColors.labelBlackTextColor,
                      //           fontSize: 13.sp,
                      //         ),
                      //       ),
                      //       Spacer(),
                      //       Text(
                      //         '5,000',
                      //         style: AppTextStyles.labelLarge.copyWith(
                      //           color: AppColors.priceTextColor,
                      //           height: 1.2,
                      //         ),
                      //       ),
                      //       7.widthSpace,
                      //       SvgPicture.asset(
                      //         SvgAssets.assetsSvgSarIcon,
                      //         color: AppColors.primaryColor,
                      //         width: 10.w,
                      //         height: 10.h,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.buttonBackBKColor),
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   padding: EdgeInsets.only(
                      //     left: 14,
                      //     right: 14,
                      //     top: 10,
                      //     bottom: 33,
                      //   ).r,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text('رقم بطاقة الدفع', style: AppTextStyles.labelSmall),
                      //       8.heightSpace,
                      //       SizedBox(
                      //         height: 44.h,
                      //         child: CustomTextField(
                      //           hintText: 'ادخل الرقم',
                      //           keyboardType: TextInputType.number,
                      //         ),
                      //       ),
                      //       17.heightSpace,
                      //       Text('اسم صاحب البطاقة', style: AppTextStyles.labelSmall),
                      //       8.heightSpace,
                      //       SizedBox(
                      //         height: 44.h,
                      //         child: CustomTextField(
                      //           hintText: 'ادخل اسم البطاقة',
                      //           keyboardType: TextInputType.name,
                      //         ),
                      //       ),
                      //       16.heightSpace,
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text('التاريخ', style: AppTextStyles.labelSmall),
                      //                 8.heightSpace,
                      //
                      //                 SizedBox(
                      //                   height: 44.h,
                      //                   child: CustomTextField(
                      //                     hintText: 'YY/ MM',
                      //                     keyboardType: TextInputType.name,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //           14.widthSpace,
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   'الرقم السري',
                      //                   style: AppTextStyles.labelSmall,
                      //                 ),
                      //                 8.heightSpace,
                      //
                      //                 SizedBox(
                      //                   height: 44.h,
                      //                   child: CustomTextField(
                      //                     hintText: 'CVV',
                      //                     keyboardType: TextInputType.name,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              text: S.of(context).payNow,
                              icon: SvgAssets.assetsSvgArrowRight,
                              size: Size(163.w, 48.h),
                              onPressed: () {
                                context.read<MyAdsCubit>().payAd({
                                  "ad_id": ad?.id,
                                  "payment_method": _selectedCard == 0
                                      ? 'cash'
                                      : 'my_fatoorah',
                                });
                              },
                            ),
                          ),
                          16.widthSpace,
                          Expanded(
                            child: CustomElevatedButton(
                              text: S.of(context).previous,
                              icon: SvgAssets.assetsSvgArrowLeft,
                              size: Size(163.w, 48.h),
                              backgroundColor: AppColors.buttonBackBKColor,
                              onPressed: () {
                                LocatorService.navigationService.currentState
                                    ?.popUntil(
                                      (route) =>
                                          route.settings.name ==
                                          AddAdSecondScreen.routeName,
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      50.heightSpace,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
