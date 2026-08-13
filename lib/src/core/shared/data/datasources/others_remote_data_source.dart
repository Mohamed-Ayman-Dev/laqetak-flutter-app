import '../../../network/api_client.dart';
import '../../../network/end_points.dart';
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

class OthersRemoteDataSourceImpl implements OthersRemoteDataSource {
  OthersRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<CategoryModel>?> getCategories() async {
    final response = await _apiClient.get(EndPoints.getCategories);
    final data = response.responseData['data']
        .map<CategoryModel>((e) => CategoryModel.fromJson(e))
        .toList();
    return data;
  }

  @override
  Future<List<BudgetRangeModel>?> getBudgetRanges() async {
    final response = await _apiClient.get(EndPoints.getBudgetRanges);
    final data = response.responseData['data']
        .map<BudgetRangeModel>((e) => BudgetRangeModel.fromJson(e))
        .toList();
    return data;
  }

  @override
  Future<List<DetailsModel>?> getCities() async {
    final response = await _apiClient.get(EndPoints.getCities);
    final data = response.responseData['data']
        .map<DetailsModel>((e) => DetailsModel.fromJson(e))
        .toList();
    return data;
  }

  @override
  Future<List<SectorModel>?> getSectors() async {
    final response = await _apiClient.get(EndPoints.getSectors);
    final data = response.responseData['data']
        .map<SectorModel>((e) => SectorModel.fromJson(e))
        .toList();
    return data;
  }
}
