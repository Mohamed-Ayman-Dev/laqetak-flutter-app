import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';
import '../../data/models/budget_range_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/details_model.dart';
import '../../data/models/sector_model.dart';

class OthersState extends Equatable {
  const OthersState({
    this.categories = const [],
    this.categoriesStatus = RequestStatus.initial,
    this.cities = const [],
    this.citiesStatus = RequestStatus.initial,
    this.sectors = const [],
    this.sectorsStatus = RequestStatus.initial,
    this.budgetRanges = const [],
    this.budgetRangesStatus = RequestStatus.initial,
  });

  final List<CategoryModel> categories;
  final RequestStatus categoriesStatus;

  final List<DetailsModel> cities;
  final RequestStatus citiesStatus;

  final List<SectorModel> sectors;
  final RequestStatus sectorsStatus;

  final List<BudgetRangeModel> budgetRanges;
  final RequestStatus budgetRangesStatus;

  OthersState copyWith({
    List<CategoryModel>? categories,
    RequestStatus? categoriesStatus,
    List<DetailsModel>? cities,
    RequestStatus? citiesStatus,
    List<SectorModel>? sectors,
    RequestStatus? sectorsStatus,
    List<BudgetRangeModel>? budgetRanges,
    RequestStatus? budgetRangesStatus,
  }) => OthersState(
    categories: categories ?? this.categories,
    categoriesStatus: categoriesStatus ?? this.categoriesStatus,
    cities: cities ?? this.cities,
    citiesStatus: citiesStatus ?? this.citiesStatus,
    sectors: sectors ?? this.sectors,
    sectorsStatus: sectorsStatus ?? this.sectorsStatus,
    budgetRanges: budgetRanges ?? this.budgetRanges,
    budgetRangesStatus: budgetRangesStatus ?? this.budgetRangesStatus,
  );

  @override
  List<Object?> get props => [
    categories,
    categoriesStatus,
    cities,
    citiesStatus,
    sectors,
    sectorsStatus,
    budgetRanges,
    budgetRangesStatus,
  ];
}
