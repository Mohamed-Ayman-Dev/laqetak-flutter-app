import 'package:invastro/src/core/network/api_service.dart';

import '../../../../core/network/end_points.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    final response = await _apiService.post(EndPoints.login, data: data);
    return response.dataOrThrow((data) => data);
  }

  @override
  Future<String?> register(Map<String, dynamic> data) async {
    final response = await _apiService.post(EndPoints.register, data: data);
    return response.dataOrThrow((data) => data['message']);
  }
}
