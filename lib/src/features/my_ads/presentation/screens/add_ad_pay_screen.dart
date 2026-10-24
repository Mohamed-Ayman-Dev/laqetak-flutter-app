import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/drawer_widgets/app_drawer.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/helpers/vat_helper.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../../../../core/shared/settings/presentation/cubit/settings_state.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/app_elevated_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../widgets/payment_method_item.dart';

class AddAdPayScreen extends StatefulWidget {
  static const routeName = '/add-ad-pay-screen';

  const AddAdPayScreen({super.key});

  @override
  State<AddAdPayScreen> createState() => _AddAdPayScreenState();
}

class _AddAdPayScreenState extends State<AddAdPayScreen> {
  int _selectedCard = 0;
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.read<SettingsCubit>().state.settings == null) {
          context.read<SettingsCubit>().getSettings();
        }
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  // ── Demo Mode: show info dialog instead of real payment ──────────────
  void _showDemoPaymentDialog() {
    DialogHelpers.showDemoDialog(
      message: S.of(context).demoPaymentMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, String?>(
      selector: (state) => state.settings?.costPerAd,
      builder: (context, costPerAd) {
        return Scaffold(
          appBar: CustomAppbar(
            icons: [AppbarIcons.logo, AppbarIcons.drawer],
            flexRight: 8,
          ),
          drawer: AppDrawer(),
          body: SafeArea(
            top: false,
            bottom: true,
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
                  Row(
                    children: [
                      Expanded(
                        child: AppElevatedButton(
                          text: S.of(context).payNow,
                          icon: SvgAssets.assetsSvgArrowRight,
                          size: Size(163.w, 48.h),
                          onPressed: _showDemoPaymentDialog,
                        ),
                      ),
                      16.widthSpace,
                      Expanded(
                        child: AppElevatedButton(
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
        );
      },
    );
  }
}
