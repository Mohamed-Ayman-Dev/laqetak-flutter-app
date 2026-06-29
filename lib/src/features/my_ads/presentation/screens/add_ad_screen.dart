import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/core/shared/controllers/others_controller.dart';
import 'package:invastro/src/core/shared/models/ad_model.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/category_model.dart';
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
  bool once = false;
  AdModel? ad;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _investmentAmountController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    if (!once) {
      ad = ModalRoute.of(context)?.settings.arguments as AdModel?;
      if (ad != null) {
        _formData['city_id'] = ad?.city?.id;
        _formData['category_id'] = ad?.category?.id;
        _formData['sector_id'] = ad?.sector?.id;
        _titleController.text = ad?.title ?? '';
        _investmentAmountController.text =
            ad?.investmentAmount?.toString() ?? '';
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        OthersController.getCities();
        OthersController.getSectors();
        OthersController.getCategories();
      });

      once = true;
    }
    super.didChangeDependencies();
  }

  Future<void> _send() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LocatorService.navigationService.currentState?.pushNamed(
        AddAdSecondScreen.routeName,
        arguments: {'ad': ad, 'data': _formData},
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _investmentAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.heightSpace,
                Text(
                  ad != null
                      ? S.of(context).editYourAd
                      : S.of(context).addYourAd,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.titleTextColor,
                    fontSize: 16.sp,
                  ),
                ),
                25.heightSpace,
                Text(S.of(context).city, style: AppTextStyles.labelSmall),
                8.heightSpace,
                Selector<Others, List<DetailsModel>?>(
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
                      onSaved: (val) {},
                    );
                  },
                ),

                28.heightSpace,
                Text(
                  S.of(context).enterAdTitle,
                  style: AppTextStyles.labelSmall,
                ),
                8.heightSpace,
                CustomTextField(
                  hintText: S.of(context).writeATitleForTheAd,
                  onSaved: (val) {
                    _formData['title'] = val;
                  },
                  controller: _titleController,
                  keyboardType: TextInputType.name,

                  validator: (value) {
                    return ValidationHelper.validateEmpty(
                      value,
                      emptyMessage: S.of(context).pleaseEnterAdName,
                    );
                  },
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                ),
                23.heightSpace,
                Text(
                  S.of(context).selectMainCategory,
                  style: AppTextStyles.labelSmall,
                ),
                8.heightSpace,
                Selector<Others, List<CategoryModel>?>(
                  selector: (context, provider) => provider.myCategories,
                  builder: (context, myCategories, child) {
                    return MyCustomDropdownFormField(
                      hint: S.of(context).selectCategory,
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
                      validator: (value) {
                        if (value == null) {
                          return S.of(context).pleaseSelectACategory;
                        }
                        return null;
                      },
                      value: _formData['category_id'],
                      onChanged: (val) {
                        _formData['category_id'] = val;
                      },
                      onSaved: (val) {},
                    );
                  },
                ),
                7.heightSpace,
                Text(
                  S.of(context).selectInvestmentSector,
                  style: AppTextStyles.labelSmall,
                ),
                8.heightSpace,
                Selector<Others, List<DetailsModel>?>(
                  selector: (context, provider) => provider.mySectors,
                  builder: (context, mySectors, child) {
                    return MyCustomDropdownFormField(
                      hint: S.of(context).selectSector,
                      // items: myCities
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
                      value: _formData['sector_id'],
                      validator: (value) {
                        if (value == null) {
                          return S.of(context).pleaseSelectASector;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        _formData['sector_id'] = val;
                      },
                      onSaved: (val) {},
                    );
                  },
                ),
                27.heightSpace,
                Text(
                  S.of(context).enterCapital,
                  style: AppTextStyles.labelSmall,
                ),
                8.heightSpace,
                CustomTextField(
                  onSaved: (val) {
                    _formData['investment_amount'] = val;
                  },
                  validator: (value) {
                    return ValidationHelper.validateEmpty(
                      value,
                      emptyMessage: S.of(context).pleaseEnterYourPrice,
                    );
                  },
                  controller: _investmentAmountController,
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
                ),
                27.heightSpace,
                CustomElevatedButton(
                  text: S.current.next,
                  icon: SvgAssets.assetsSvgArrowRight,
                  size: Size(163.w, 48.h),
                  onPressed: () {
                    _send();
                  },
                ),
                100.heightSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
