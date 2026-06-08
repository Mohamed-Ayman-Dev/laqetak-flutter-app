import 'package:invastro/src/core/network/api_service.dart';

class ChatService {
  Future getConversations(
    Map<String, dynamic> queryParameters, {
    rethrowError = false,
  }) async {
    return await ApiService.get(
      '/conversations/list',
      queryParameters: queryParameters,
      rethrowError: rethrowError,
    );
  }
}
