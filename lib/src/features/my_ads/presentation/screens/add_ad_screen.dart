import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/drawer/app_drawer.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/add_ad_second_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/error/validation_helper.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/others/data/models/category_model.dart';
import '../../../../core/shared/others/data/models/details_model.dart';
import '../../../../core/shared/others/data/models/sector_model.dart';
import '../../../../core/shared/others/presentation/cubit/others_cubit.dart';
import '../../../../core/shared/others/presentation/cubit/others_state.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/fields/custom_drop_down_menu.dart';
import '../../../../core/widgets/fields/custom_text_field.dart';
import '../../../../core/widgets/fields/sector_select_field.dart';

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
  final TextEditingController _sectorAdditionalController =
      TextEditingController();

  final TextEditingController _investmentAmountController =
      TextEditingController();

  @override
  void didChangeDependencies() {
    if (!once) {
      ad = ModalRoute.of(context)?.settings.arguments as AdModel?;
      if (ad != null) {
        _formData['city_id'] = ad?.city?.id;
        _formData['category_id'] = ad?.category?.id;
        if (ad?.sectorAdditionalInfo != null) {
          _sectorAdditionalController.text = ad?.sectorAdditionalInfo ?? '';
        }
        _selectedCategory = ad?.category;
        _formData['sector_id'] = ad?.sector?.id;
        _titleController.text = ad?.title ?? '';
        _investmentAmountController.text =
            ad?.investmentAmount?.toString() ?? '';
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<OthersCubit>().getCities();
        context.read<OthersCubit>().getSectors();
        context.read<OthersCubit>().getCategories();
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
    _sectorAdditionalController.dispose();
    super.dispose();
  }

  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OthersCubit, OthersState>(
      listenWhen: (previous, current) => current.hasError && !previous.hasError,
      listener: (context, state) =>
          AppFeedback.errorMessage(state.errorMessage),
      child: Scaffold(
        appBar: CustomAppbar(
          icons: [AppbarIcons.logo, AppbarIcons.drawer],
          flexRight: 8,
        ),
        drawer: AppDrawer(),
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
                  BlocSelector<OthersCubit, OthersState, List<DetailsModel>>(
                    selector: (state) => state.cities,
                    builder: (context, myCities) {
                      return CustomDropdownFormField<DetailsModel>(
                        hint: S.of(context).selectCity,
                        items: myCities,
                        itemAsString: (item) => item.name ?? '',
                        value: _formData['city_id'] == null
                            ? null
                            : myCities.firstWhere(
                                (e) => e.id == _formData['city_id'],
                                orElse: () => DetailsModel(),
                              ),
                        validator: (value) {
                          if (value == null) {
                            return S.of(context).pleaseSelectACity;
                          }
                          return null;
                        },
                        onChanged: (val) {
                          _formData['city_id'] = val?.id;
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
                  BlocSelector<OthersCubit, OthersState, List<CategoryModel>>(
                    selector: (state) => state.categories,
                    builder: (context, myCategories) {
                      return CustomDropdownFormField<CategoryModel>(
                        hint: S.of(context).selectCategory,
                        items: myCategories,
                        itemAsString: (item) => item.name ?? '',
                        validator: (value) {
                          if (value == null) {
                            return S.of(context).pleaseSelectACategory;
                          }
                          return null;
                        },
                        value: _formData['category_id'] == null
                            ? null
                            : myCategories.firstWhere(
                                (e) => e.id == _formData['category_id'],
                                orElse: () => CategoryModel(),
                              ),
                        onChanged: (val) {
                          _formData['category_id'] = val?.id;
                          _selectedCategory = val;
                        },
                        onSaved: (val) {},
                      );
                    },
                  ),
                  7.heightSpace,
                  if (_selectedCategory != null)
                    Text(
                      _selectedCategory?.slug == 'investment'
                          ? S.of(context).projectNeedsCapital
                          : _selectedCategory?.slug == 'opportunity'
                          ? S.of(context).capitalNeedsAnIdea
                          : '',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  13.heightSpace,
                  Text(
                    S.of(context).selectInvestmentSector,
                    style: AppTextStyles.labelSmall,
                  ),
                  8.heightSpace,
                  BlocSelector<OthersCubit, OthersState, List<SectorModel>>(
                    selector: (state) => state.sectors,
                    builder: (context, mySectors) {
                      return SectorSelectField(
                        sectors: mySectors,
                        formData: _formData,
                        otherController: _sectorAdditionalController,
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
                  AppElevatedButton(
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
      ),
    );
  }
}
