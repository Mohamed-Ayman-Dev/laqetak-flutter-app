import 'package:flutter/material.dart';
import 'package:invastro/src/features/chat/data/models/conversations_model.dart';

import '../../../../core/shared/models/pagination_list.dart';

class Chat with ChangeNotifier {
  PaginationList<ConversationsModel>? myConversations;
  bool isLoadingConversations = false;

  void setLoadingConversations(bool value) {
    isLoadingConversations = value;
    notifyListeners();
  }

  void setConversations(dynamic data, bool refresh) {
    if (myConversations == null || refresh) {
      myConversations = PaginationList.fromJson(data);
    } else {
      myConversations?.addItemsToList(data);
    }
    notifyListeners();
  }
}
