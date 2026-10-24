import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:laqetak/src/core/constants/app_feedback.dart';
import 'package:laqetak/src/core/constants/enums.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/core/widgets/buttons_widgets/app_outline_button.dart';
import 'package:laqetak/src/core/widgets/drawer_widgets/app_drawer.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/svg_assets.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/others/data/models/budget_range_model.dart';
import '../../../../core/shared/others/data/models/category_model.dart';
import '../../../../core/shared/others/data/models/details_model.dart';
import '../../../../core/shared/others/data/models/sector_model.dart';
import '../../../../core/shared/others/presentation/cubit/others_cubit.dart';
import '../../../../core/shared/others/presentation/cubit/others_state.dart';
import '../../../../core/themes/text_styles.dart';
import '../../../../core/widgets/buttons_widgets/app_elevated_button.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/fields_widgets/custom_drop_down_menu.dart';
import '../../../../core/widgets/fields_widgets/custom_multi_drop_down_menu.dart';
import '../../../home/presentation/cubit/ads_cubit.dart';

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
      context.read<OthersCubit>().loadAll();
    });
    super.initState();
  }

  BudgetRangeModel? selectedPrice;

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
          child: Form(
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
                      Text(
                        S.of(context).category,
                        style: AppTextStyles.labelLarge,
                      ),
                    ],
                  ),
                  10.heightSpace,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44.h,
                          child:
                              BlocSelector<
                                OthersCubit,
                                OthersState,
                                List<CategoryModel>
                              >(
                                selector: (state) => state.categories,
                                builder: (context, myCategories) {
                                  final allOption = CategoryModel(
                                    id: -1,
                                    name: S.of(context).all,
                                  );
                                  final items = [allOption, ...myCategories];

                                  final currentCategoryId =
                                      _formData['category_id'] ?? -1;

                                  return CustomDropdownFormField<CategoryModel>(
                                    hint: S.of(context).selectCategory,
                                    items: items,
                                    itemAsString: (item) => item.name ?? '',
                                    value: items.firstWhere(
                                      (e) => e.id == currentCategoryId,
                                      orElse: () => allOption,
                                    ),
                                    onChanged: (val) {
                                      if (val == null || val.id == -1) {
                                        _formData['category_id'] = null;
                                      } else {
                                        _formData['category_id'] = val.id;
                                      }
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
                      Text(S.of(context).city, style: AppTextStyles.labelLarge),
                    ],
                  ),
                  10.heightSpace,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44.h,
                          child:
                              BlocSelector<
                                OthersCubit,
                                OthersState,
                                List<DetailsModel>
                              >(
                                selector: (state) => state.cities,
                                builder: (context, myCities) {
                                  final allOption = DetailsModel(
                                    id: -1,
                                    name: S.of(context).all,
                                  );
                                  final items = [allOption, ...myCities];

                                  final selectedIds =
                                      (_formData['cities[]'] as List?) ?? [];
                                  final selectedItems = selectedIds.isEmpty
                                      ? [allOption]
                                      : items
                                            .where(
                                              (e) => selectedIds.contains(e.id),
                                            )
                                            .toList();

                                  return CustomMultiDropdownFormField<
                                    DetailsModel
                                  >(
                                    hint: S.of(context).selectCity,
                                    items: items,
                                    itemAsString: (item) => item.name ?? '',
                                    compareFn: (a, b) => a.id == b.id,
                                    selectedItems: selectedItems,
                                    onChanged: (values) {
                                      final pickedReal = values
                                          .where((e) => e.id != -1)
                                          .toList();
                                      if (pickedReal.isNotEmpty) {
                                        _formData['cities[]'] = pickedReal
                                            .map((e) => e.id)
                                            .toList();
                                      } else {
                                        _formData['cities[]'] = [];
                                      }
                                    },
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
                      Text(
                        S.of(context).investmentSector,
                        style: AppTextStyles.labelLarge,
                      ),
                    ],
                  ),
                  10.heightSpace,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44.h,

                          child:
                              BlocSelector<
                                OthersCubit,
                                OthersState,
                                List<SectorModel>
                              >(
                                selector: (state) => state.sectors,
                                builder: (context, mySectors) {
                                  final allOption = SectorModel(
                                    id: -1,
                                    name: S.of(context).all,
                                  );
                                  final items = [allOption, ...mySectors];

                                  final selectedIds =
                                      (_formData['sectors[]'] as List?) ?? [];
                                  final selectedItems = selectedIds.isEmpty
                                      ? [allOption]
                                      : items
                                            .where(
                                              (e) => selectedIds.contains(e.id),
                                            )
                                            .toList();

                                  return CustomMultiDropdownFormField<
                                    SectorModel
                                  >(
                                    hint: S.of(context).investmentSector,
                                    items: items,
                                    itemAsString: (item) => item.name ?? '',
                                    compareFn: (a, b) => a.id == b.id,
                                    selectedItems: selectedItems,
                                    onChanged: (values) {
                                      final pickedReal = values
                                          .where((e) => e.id != -1)
                                          .toList();

                                      if (pickedReal.isNotEmpty) {
                                        _formData['sectors[]'] = pickedReal
                                            .map((e) => e.id)
                                            .toList();
                                      } else {
                                        _formData['sectors[]'] = [];
                                      }
                                    },
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
                      Text(
                        S.of(context).averageCapital,
                        style: AppTextStyles.labelLarge,
                      ),
                    ],
                  ),
                  10.heightSpace,
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 44.h,
                          child:
                              BlocSelector<
                                OthersCubit,
                                OthersState,
                                List<BudgetRangeModel>
                              >(
                                selector: (state) => state.budgetRanges,
                                builder: (context, myBudgetRanges) {
                                  final allOption = BudgetRangeModel(
                                    id: -1,
                                    name: S.of(context).all,
                                  );
                                  final items = [allOption, ...myBudgetRanges];

                                  // نحدد العنصر الحالي بمقارنة amountFrom/amountTo المخزنة في _formData
                                  final currentItem = myBudgetRanges.firstWhere(
                                    (e) =>
                                        e.amountFrom ==
                                            _formData['price_from'] &&
                                        e.amountTo == _formData['price_to'],
                                    orElse: () => allOption,
                                  );

                                  return CustomDropdownFormField<
                                    BudgetRangeModel
                                  >(
                                    hint: "500.000  :  100.000",
                                    // أو النص اللي عندك بالظبط
                                    items: items,
                                    itemAsString: (item) => item.name ?? '',
                                    value: currentItem,
                                    onChanged: (val) {
                                      if (val == null || val.id == -1) {
                                        _formData['price_from'] = null;
                                        _formData['price_to'] = null;
                                      } else {
                                        _formData['price_from'] =
                                            val.amountFrom;
                                        _formData['price_to'] = val.amountTo;
                                      }
                                    },
                                    perfixIcon:
                                        (_formData['price_from'] == null &&
                                            _formData['price_to'] == null)
                                        ? SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ).r,
                                            child: SvgPicture.asset(
                                              SvgAssets.assetsSvgSarIcon,
                                            ),
                                          ),
                                    onSaved: (val) {},
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
                        child: AppOutlineButton(
                          text: S.of(context).reset,
                          borderRadius: 12,

                          onPressed: () {
                            _formData.clear();
                            context.read<AdsCubit>().setFilters(_formData);
                            Navigator.pop(context, _formData);
                          },
                        ),
                      ),
                      10.widthSpace,
                      Expanded(
                        child: AppElevatedButton(
                          text: S.of(context).apply,
                          borderRadius: 12,
                          onPressed: () {
                            context.read<AdsCubit>().setFilters(_formData);
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
        ),
      ),
    );
  }
}
