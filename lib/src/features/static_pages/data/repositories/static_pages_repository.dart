import '../../../../core/network/api_result.dart';
import '../models/faq_model.dart';

abstract class StaticPagesRepository {
  Future<ApiResult<List<FaqModel>?>> getFaqs();

  Future<ApiResult<void>> sendContactUs(Map<String, dynamic> data);
}
