abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>?> login(Map<String, dynamic> data);

  Future<String?> register(Map<String, dynamic> data);
}
