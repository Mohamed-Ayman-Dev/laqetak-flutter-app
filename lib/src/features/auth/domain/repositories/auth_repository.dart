import 'package:invastro/src/core/network/api_result.dart';

abstract class AuthRepository {
  Future<ApiResult<Map<String, dynamic>?>> login(Map<String, dynamic> data);

  Future<ApiResult<String>> register(Map<String, dynamic> data);
}
