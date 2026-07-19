import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/controllers/others_controller.dart';
import 'package:invastro/src/core/shared/models/budget_range_model.dart';
import 'package:invastro/src/core/shared/models/category_model.dart';
import 'package:invastro/src/core/shared/widgets/buttons_widgets/custom_outline_button.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
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
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _formData.addAll(args);
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OthersController.getCategories();
      OthersController.getSectors();
      OthersController.getCities();
      OthersController.getBudgetRanges();
    });
    super.initState();
  }

  // num? get selectedPriceId {
  //   final priceFrom = _formData['price_from'];
  //   final priceTo = _formData['price_to'];
  //
  //   if (priceFrom == 100000 && priceTo == 500000) {
  //     return 1;
  //   }
  //
  //   if (priceFrom == 500000 && priceTo == 1000000) {
  //     return 2;
  //   }
  //
  //   if (priceFrom == 1000000 && priceTo == null) {
  //     return 3;
  //   }
  //
  //   return null;
  // }
  BudgetRangeModel? selectedPrice;

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
                S.of(context).filter,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.titleTextColor,
                  fontSize: 16.sp,
                ),
              ),
              25.heightSpace,
              Row(
                children: [
                  // CustomCheckbox(
                  //   isChecked: _formData['category_id'] != null,
                  //   onTap: (value) {},
                  //   size: 17,
                  //   unSelectedBorderColor: AppColors.unSelectedRadioBKColor,
                  //   selectedColor: AppColors.primaryColor,
                  // ),
                  // 14.widthSpace,
                  Text(S.of(context).category, style: AppTextStyles.labelLarge),
                ],
              ),
              10.heightSpace,
              Row(
                children: [
                  // 34.widthSpace,
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<CategoryModel>?>(
                        selector: (context, provider) => provider.myCategories,
                        builder: (context, myCategories, child) {
                          return MyCustomDropdownFormField(
                            hint: S.of(context).selectCategory,
                            // items: myCities
                            items: myCategories
                                ?.map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: Text(
                                      e.name ?? '',
                                      style: AppTextStyles.inputTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            value: _formData['category_id'],
                            onChanged: (val) {
                              // setState(() {
                              _formData['category_id'] = val;
                              // });
                            },
                            onSaved: (val) {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Divider(height: 60.h),
              // Row(
              //   children: [
              //     CustomRadioButton(onChanged: (p0) {}, isSelected: true),
              //     14.widthSpace,
              //     Text('الأحدث', style: AppTextStyles.labelLarge),
              //   ],
              // ),
              Divider(height: 40.h),
              Row(
                children: [
                  // CustomCheckbox(
                  //   isChecked: _formData['city_id'] != null,
                  //   onTap: (value) {},
                  //   size: 17,
                  //   unSelectedBorderColor: AppColors.unSelectedRadioBKColor,
                  //   selectedColor: AppColors.primaryColor,
                  // ),
                  // 14.widthSpace,
                  Text(S.of(context).city, style: AppTextStyles.labelLarge),
                ],
              ),
              10.heightSpace,
              Row(
                children: [
                  // 34.widthSpace,
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<DetailsModel>?>(
                        selector: (context, provider) => provider.myCities,
                        builder: (context, myCities, child) {
                          return MyCustomDropdownFormField(
                            hint: S.of(context).selectCity,
                            items: myCities
                                ?.map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: Text(
                                      e.name ?? '',
                                      style: AppTextStyles.inputTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            value: _formData['cities[]'],

                            onChanged: (val) {
                              // setState(() {
                              _formData['cities[]'] = val;
                              // });
                            },
                            onSaved: (val) {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 40.h),
              Row(
                children: [
                  // CustomCheckbox(
                  //   isChecked: _formData['sector_id'] != null,
                  //   onTap: (value) {},
                  //   size: 17,
                  //   unSelectedBorderColor: AppColors.unSelectedRadioBKColor,
                  //   selectedColor: AppColors.primaryColor,
                  // ),
                  // 14.widthSpace,
                  Text(
                    S.of(context).investmentSector,
                    style: AppTextStyles.labelLarge,
                  ),
                ],
              ),
              10.heightSpace,
              Row(
                children: [
                  // 34.widthSpace,
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<DetailsModel>?>(
                        selector: (context, provider) => provider.mySectors,
                        builder: (context, mySectors, child) {
                          return MyCustomDropdownFormField(
                            hint: S.of(context).investmentSector,
                            items: mySectors
                                ?.map<DropdownMenuItem<num>>(
                                  (e) => DropdownMenuItem<num>(
                                    value: e.id,
                                    child: Text(
                                      e.name ?? '',
                                      style: AppTextStyles.inputTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            value: _formData['sectors[]'],
                            onChanged: (val) {
                              // setState(() {
                              _formData['sectors[]'] = val;
                              // });
                            },
                            onSaved: (val) {},
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(height: 40.h),
              Row(
                children: [
                  // CustomCheckbox(
                  //   isChecked: _formData['price_from'] != null,
                  //   onTap: (value) {},
                  //   size: 17,
                  //   unSelectedBorderColor: AppColors.unSelectedRadioBKColor,
                  //   selectedColor: AppColors.primaryColor,
                  // ),
                  // 14.widthSpace,
                  Text(
                    S.of(context).averageCapital,
                    style: AppTextStyles.labelLarge,
                  ),
                ],
              ),
              10.heightSpace,
              Row(
                children: [
                  // 34.widthSpace,
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: Selector<Others, List<BudgetRangeModel>?>(
                        selector: (context, provider) =>
                            provider.myBudgetRanges,
                        builder: (context, myBudgetRanges, child) {
                          return MyCustomDropdownFormField(
                            hint: "500.000  :  100.000",
                            items: myBudgetRanges
                                ?.map<DropdownMenuItem<BudgetRangeModel?>>(
                                  (e) => DropdownMenuItem<BudgetRangeModel?>(
                                    value: e,
                                    child: Text(
                                      e.name ?? '',
                                      style: AppTextStyles.inputTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                                .toList(),
                            value:
                                (myBudgetRanges?.any(
                                      (e) =>
                                          (e.amountFrom ==
                                              _formData['price_from'] &&
                                          e.amountTo == _formData['price_to']),
                                    ) ==
                                    true)
                                ? myBudgetRanges?.firstWhere(
                                    (e) =>
                                        (e.amountFrom ==
                                            _formData['price_from'] &&
                                        e.amountTo == _formData['price_to']),
                                  )
                                : null,
                            onChanged: (val) {
                              _formData['price_from'] = val?.amountFrom;
                              _formData['price_to'] = val?.amountTo;
                            },
                            suffix: SvgPicture.asset(
                              SvgAssets.assetsSvgSarIcon,
                            ),
                            onSaved: (val) {
                              _formData['price_from'] = val?.amountFrom;
                              _formData['price_to'] = val?.amountTo;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              50.heightSpace,
              Row(
                children: [
                  Expanded(
                    child: CustomOutlineButton(
                      text: S.of(context).reset,
                      borderRadius: 12,

                      onPressed: () {
                        _formData.clear();
                        LocatorService.ads.setFilters(_formData);
                        Navigator.pop(context, _formData);
                      },
                    ),
                  ),
                  10.widthSpace,
                  Expanded(
                    child: CustomElevatedButton(
                      text: S.of(context).apply,
                      borderRadius: 12,
                      onPressed: () {
                        LocatorService.ads.setFilters(_formData);
                        Navigator.pop(context, _formData);
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
  }
}
