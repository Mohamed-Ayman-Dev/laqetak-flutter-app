import '../../../../../generated/l10n.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<Map<String, dynamic>?>> login(
      Map<String, dynamic> data,) async {
    try {
      final response = await _remoteDataSource.login(data);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(
        e is ApiException ? e : ApiException(message: e.toString()),
      );
    }
  }

  @override
  Future<ApiResult<String>> register(Map<String, dynamic> data) async {
    try {
      final responseMessage = await _remoteDataSource.register(data);
      return ApiResult.success(
        responseMessage ?? S.current.youLoggedInSuccessfully,
      );
    } catch (e) {
      return ApiResult.failure(
        e is ApiException ? e : ApiException(message: e.toString()),
      );
    }
  }
}
