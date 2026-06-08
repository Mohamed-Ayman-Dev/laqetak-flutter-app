import 'package:invastro/src/features/chat/data/models/conversations_model.dart';

import '../../../../core/di/locator_service.dart';
import '../../../../core/error/error_helper.dart';

class ChatController {
  static Future<void> getConversations({bool refresh = false}) async {
    LocatorService.chat.setLoadingConversations(true);
    try {
      int? currentPage = LocatorService.chat.myConversations?.currentPage;
      int? lastPage = LocatorService.chat.myConversations?.lastPage;
      int nextPage = refresh ? 1 : ((currentPage ?? 0) + 1);
      if (!refresh && currentPage != null && currentPage == lastPage) return;
      final response = await LocatorService.chatService.getConversations({
        'page': nextPage,
      }, rethrowError: true);
      response["data"] = response["data"]
          .map<ConversationsModel>((x) => ConversationsModel.fromJson(x))
          .toList();
      LocatorService.chat.setConversations(response, refresh);
    } catch (e) {
      ErrorHelper.handleApiError(e);
    } finally {
      LocatorService.chat.setLoadingConversations(false);
    }
  }
}
