import '../models/budget_range_model.dart';
import '../models/category_model.dart';
import '../models/details_model.dart';
import '../models/sector_model.dart';

/// Defines the contract for fetching data from the remote API.
abstract class OthersRemoteDataSource {
  Future<List<CategoryModel>?> getCategories();

  Future<List<DetailsModel>?> getCities();

  Future<List<BudgetRangeModel>?> getBudgetRanges();

  Future<List<SectorModel>?> getSectors();
}
