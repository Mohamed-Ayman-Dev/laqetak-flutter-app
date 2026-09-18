import '../models/faq_model.dart';

abstract class StaticPagesRemoteDataSource {
  Future<List<FaqModel>?> getFaqs();

  Future<void> sendContactUs(Map<String, dynamic> data);
}
