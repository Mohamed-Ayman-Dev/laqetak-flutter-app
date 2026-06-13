import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/controllers/settings_controller.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/themes/text_styles.dart';
import '../controllers/my_ads_controller.dart';
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
  Map<String, dynamic>? _formData = {};

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        _formData = args;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (LocatorService.appSettings.mySettings == null) {
          SettingsController.getGeneralSettings();
        }
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],

        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30).r,
                  decoration: BoxDecoration(
                    color: AppColors.searchBKColor,
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'سعر العمولة',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.labelBlackTextColor,
                          fontSize: 13.sp,
                        ),
                      ),
                      Spacer(),
                      Text(
                        LocatorService.appSettings.mySettings?.costPerAd ?? '',
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
                ),
              ),
              30.heightSpace,
              Text(
                'أختر طريقة الدفع',
                style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
              ),
              20.heightSpace,

              PaymentMethodItem(
                title: S.of(context).cash,
                cardType: PaymentMethods.cash,
                isSelected: _selectedCard == 0,
                onTap: () => setState(() => _selectedCard = 0),
              ),
              // 12.heightSpace,
              // PaymentMethodItem(
              //   title: S.of(context).card,
              //   cardType: PaymentMethods.card,
              //   isSelected: _selectedCard == 1,
              //   onTap: () => setState(() => _selectedCard = 1),
              // ),
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
              350.heightSpace,
              Row(
                children: [
                  CustomElevatedButton(
                    text: 'ادفع الان',
                    icon: SvgAssets.assetsSvgArrowRight,
                    size: Size(163.w, 48.h),
                    onPressed: () {
                      _formData?['payment_method'] = 'cash';
                      MyAdsController.sendAdOtp(_formData);
                    },
                  ),
                  16.widthSpace,
                  CustomElevatedButton(
                    text: 'السابق',
                    icon: SvgAssets.assetsSvgArrowLeft,
                    size: Size(163.w, 48.h),
                    backgroundColor: AppColors.buttonBackBKColor,
                    onPressed: () {
                      LocatorService.navigationService.currentState?.popUntil(
                        (route) =>
                            route.settings.name == AddAdSecondScreen.routeName,
                      );
                    },
                  ),
                ],
              ),
              50.heightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
