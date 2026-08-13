import '../../../../core/network/api_result.dart';
import '../models/budget_range_model.dart';
import '../models/category_model.dart';
import '../models/details_model.dart';
import '../models/sector_model.dart';

/// Defines the contract for retrieving data.

abstract class OthersRepository {
  Future<ApiResult<List<CategoryModel>?>> getCategories();
  Future<ApiResult<List<DetailsModel>?>> getCities();
  Future<ApiResult<List<BudgetRangeModel>?>> getBudgetRanges();
  Future<ApiResult<List<SectorModel>?>> getSectors();
}
