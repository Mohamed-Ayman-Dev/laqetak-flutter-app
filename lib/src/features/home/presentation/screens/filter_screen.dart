import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/widgets/custom_radio_button.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/details_model.dart';
import '../../../../core/shared/providers/others.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/fields_widgets/my_custom_drop_down_menu.dart';
import '../../../../core/themes/text_styles.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';

  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};

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
          padding: EdgeInsets.symmetric(horizontal: 25).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace,
              Text(
                'الفلتر',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.titleTextColor,
                  fontSize: 16.sp,
                ),
              ),
              25.heightSpace,
              Row(
                children: [
                  CustomRadioButton(onChanged: (p0) {}, isSelected: false),
                  14.widthSpace,
                  Text('القسم', style: AppTextStyles.labelLarge),
                ],
              ),
              10.heightSpace,
              Row(
                children: [
                  34.widthSpace,

                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<DetailsModel>?>(
                        selector: (context, provider) => provider.myCities,
                        builder: (context, myCities, child) {
                          return MyCustomDropdownFormField(
                            hint: "اختر القسم",
                            // items: myCities
                            items: MockDataForLoading.mockCategories
                                .map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles.inputTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: _formData['city_id'],
                            validator: (value) {
                              if (value == null) {
                                return S.of(context).pleaseSelectACity;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              _formData['city_id'] = val;
                            },
                            onSaved: (val) {
                              _formData['city_id'] = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 60.h),
              Row(
                children: [
                  CustomRadioButton(onChanged: (p0) {}, isSelected: true),
                  14.widthSpace,
                  Text('الأحدث', style: AppTextStyles.labelLarge),
                ],
              ),
              Divider(height: 30.h),
              Row(
                children: [
                  CustomRadioButton(onChanged: (p0) {}, isSelected: false),
                  14.widthSpace,
                  Text('المدينة', style: AppTextStyles.labelLarge),
                ],
              ),
              8.heightSpace,
              Row(
                children: [
                  34.widthSpace,
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<DetailsModel>?>(
                        selector: (context, provider) => provider.myCities,
                        builder: (context, myCities, child) {
                          return MyCustomDropdownFormField(
                            hint: "اختر المدينة",
                            // items: myCities
                            items: MockDataForLoading.mockCites
                                .map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: SizedBox(
                                      width: 100.w,
                                      child: Text(
                                        e.name ?? '',
                                        style: AppTextStyles.inputTextStyle,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            value: _formData['city_id'],
                            validator: (value) {
                              if (value == null) {
                                return S.of(context).pleaseSelectACity;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              _formData['city_id'] = val;
                            },
                            onSaved: (val) {
                              _formData['city_id'] = val;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              27.heightSpace,
              CustomElevatedButton(
                text: 'التالي',
                icon: SvgAssets.assetsSvgArrowRight,
                size: Size(163.w, 48.h),
                onPressed: () {
                  // _send();
                  LocatorService.navigationService.currentState?.pushNamed(
                    AddAdSecondScreen.routeName,
                  );
                },
              ),
              100.heightSpace,
            ],
          ),
        ),
      ),
    );
  }
}
