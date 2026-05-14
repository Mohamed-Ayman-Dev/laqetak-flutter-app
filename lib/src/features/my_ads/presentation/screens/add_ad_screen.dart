import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/mock_data_for_loading.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/details_model.dart';
import '../../../../core/shared/providers/others.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../../../../core/shared/widgets/fields_widgets/custom_textField.dart';
import '../../../../core/shared/widgets/fields_widgets/my_custom_drop_down_menu.dart';
import '../../../../core/themes/text_styles.dart';

class AddAdScreen extends StatefulWidget {
  static const routeName = '/add-ad-screen';

  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {};
  bool _isEdit = false;
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      _isEdit = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
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
          padding: EdgeInsets.symmetric(horizontal: 16).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightSpace,
              Text(
                'أضف إعلانك',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.titleTextColor,
                  fontSize: 16.sp,
                ),
              ),
              25.heightSpace,
              Text('المدينة', style: AppTextStyles.labelSmall),
              8.heightSpace,
              Selector<Others, List<DetailsModel>?>(
                selector: (context, provider) => provider.myCities,
                builder: (context, myCities, child) {
                  return MyCustomDropdownFormField(
                    hint: S.of(context).city,
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
              28.heightSpace,
              Text('أدخل عنوان الإعلان', style: AppTextStyles.labelSmall),
              8.heightSpace,
              CustomTextField(
                hintText: 'اكتب عنوان للإعلان',
                onSaved: (val) {
                  _formData['address'] = val;
                },
                keyboardType: TextInputType.name,

                validator: (value) {
                  return ValidationHelper.validateEmpty(
                    value,
                    emptyMessage: 'Please enter your address',
                  );
                },
                textInputAction: TextInputAction.next,
                maxLines: 1,
              ),
              23.heightSpace,
              Text('إختر القسم الرئيسي', style: AppTextStyles.labelSmall),
              8.heightSpace,
              Selector<Others, List<DetailsModel>?>(
                selector: (context, provider) => provider.myCities,
                builder: (context, myCities, child) {
                  return MyCustomDropdownFormField(
                    hint: 'القسم',
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
                    value: _formData['category_id'],
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).pleaseSelectACity;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _formData['category_id'] = val;
                    },
                    onSaved: (val) {
                      _formData['category_id'] = val;
                    },
                  );
                },
              ),
              7.heightSpace,
              Text('إختر قطاع الإستثمار', style: AppTextStyles.labelSmall),
              8.heightSpace,
              Selector<Others, List<DetailsModel>?>(
                selector: (context, provider) => provider.myCities,
                builder: (context, myCities, child) {
                  return MyCustomDropdownFormField(
                    hint: 'القطاع',
                    // items: myCities
                    items: MockDataForLoading.mockBusiness
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
                    value: _formData['business_id'],
                    validator: (value) {
                      if (value == null) {
                        return S.of(context).pleaseSelectACity;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      _formData['business_id'] = val;
                    },
                    onSaved: (val) {
                      _formData['business_id'] = val;
                    },
                  );
                },
              ),
              27.heightSpace,
              Text('أدخل رأس المال', style: AppTextStyles.labelSmall),
              8.heightSpace,
              CustomTextField(
                onChanged: (value) {
                  setState(() {});
                },
                onSaved: (val) {
                  _formData['price'] = val;
                },
                validator: (value) {
                  return ValidationHelper.validateEmpty(
                    value,
                    emptyMessage: 'S.of(context).pleaseEnterYourPrice',
                  );
                },
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                hintText: "000.000",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(17.0).r,
                  child: SvgPicture.asset(
                    SvgAssets.assetsSvgSarIcon,
                    color: AppColors.primaryColor,
                  ),
                ),

                // textDirection: TextDirection.ltr,
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
                    arguments: _isEdit,
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
