import 'package:laqetak/src/features/static_pages/data/datasources/static_pages_remote_data_source.dart';
import 'package:laqetak/src/features/static_pages/data/models/faq_model.dart';
import 'package:laqetak/src/features/static_pages/data/repositories/static_pages_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_result.dart';

class StaticPagesRepositoryImpl implements StaticPagesRepository {
  StaticPagesRepositoryImpl({
    required StaticPagesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final StaticPagesRemoteDataSource _remoteDataSource;

  @override
  Future<ApiResult<List<FaqModel>?>> getFaqs() async {
    try {
      final faqs = await _remoteDataSource.getFaqs();
      return ApiResult.success(faqs);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }

  @override
  Future<ApiResult<void>> sendContactUs(Map<String, dynamic> data) async {
    try {
      await _remoteDataSource.sendContactUs(data);
      return ApiResult.success(null);
    } on ApiException catch (e) {
      return ApiResult.failure(e);
    }
  }
}
