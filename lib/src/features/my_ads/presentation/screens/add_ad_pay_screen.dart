import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/shared/widgets/fields_widgets/custom_textField.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:invastro/src/features/my_ads/presentation/widgets/payment_card_item.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/themes/text_styles.dart';

class AddAdPayScreen extends StatefulWidget {
  static const routeName = '/add-ad-pay-screen';

  const AddAdPayScreen({super.key});

  @override
  State<AddAdPayScreen> createState() => _AddAdPayScreenState();
}

class _AddAdPayScreenState extends State<AddAdPayScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};
  final FocusNode _phoneFocusNode = FocusNode();
  bool _isRequired = false;
  int _selectedCard = 0;

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
                        '5,000',
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
              11.heightSpace,
              PaymentCardItem(
                lastFourDigits: '4679',
                cardType: CardType.mastercard,
                isSelected: _selectedCard == 0,
                onTap: () => setState(() => _selectedCard = 0),
              ),
              12.heightSpace,
              PaymentCardItem(
                lastFourDigits: '1234',
                cardType: CardType.visa,
                isSelected: _selectedCard == 1,
                onTap: () => setState(() => _selectedCard = 1),
              ),
              18.heightSpace,
              Text(
                'أدخل بيانات بطاقة الدفع',
                style: AppTextStyles.labelSmall.copyWith(fontSize: 16.sp),
              ),
              24.heightSpace,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 30).r,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      '5,000',
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.buttonBackBKColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 10,
                  bottom: 33,
                ).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('رقم بطاقة الدفع', style: AppTextStyles.labelSmall),
                    8.heightSpace,
                    SizedBox(
                      height: 44.h,
                      child: CustomTextField(
                        hintText: 'ادخل الرقم',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    17.heightSpace,
                    Text('اسم صاحب البطاقة', style: AppTextStyles.labelSmall),
                    8.heightSpace,
                    SizedBox(
                      height: 44.h,
                      child: CustomTextField(
                        hintText: 'ادخل اسم البطاقة',
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    16.heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('التاريخ', style: AppTextStyles.labelSmall),
                              8.heightSpace,

                              SizedBox(
                                height: 44.h,
                                child: CustomTextField(
                                  hintText: 'YY/ MM',
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                        14.widthSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الرقم السري',
                                style: AppTextStyles.labelSmall,
                              ),
                              8.heightSpace,

                              SizedBox(
                                height: 44.h,
                                child: CustomTextField(
                                  hintText: 'CVV',
                                  keyboardType: TextInputType.name,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              24.heightSpace,
              Row(
                children: [
                  CustomElevatedButton(
                    text: 'ادفع الان',
                    icon: SvgAssets.assetsSvgArrowRight,
                    size: Size(163.w, 48.h),
                    onPressed: () {
                      // _send();
                      DialogHelpers.showSuccessDialog(
                        title: 'تهانينا لقد تم الدفع بنجاح',
                        subtitle: 'وتم رفع الإعلان',
                      );
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
