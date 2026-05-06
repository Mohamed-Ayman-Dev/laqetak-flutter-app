import 'package:invastro/src/core/network/api_result.dart';

import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<ApiResult<Map<String, dynamic>?>> call(Map<String, dynamic> data) {
    return _repository.login(data);
  }
}
