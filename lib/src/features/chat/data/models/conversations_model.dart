import 'package:invastro/src/features/chat/data/models/message_model.dart';

import '../../../../core/shared/data/models/customer_model.dart';

/// id : 3
/// other_user : {"id":35,"name":"Karim Taha","avatar":"https://invastro.dev4.wady.sa/storage/5/6a1ed9e365f7d_person1.jpeg"}
/// latest_message : {"id":3,"message":"test","has_files":false,"created_at":"2026-06-08T19:21:02.000000Z","created_at_human":"6 ثواني"}
/// unseen_count : 0
/// updated_at : "2026-06-08T19:21:02.000000Z"
/// updated_at_human : "6 ثواني"

class ConversationsModel {
  ConversationsModel({
    this.id,
    this.otherUser,
    this.latestMessage,
    this.unseenCount,
    this.updatedAt,
    this.updatedAtHuman,
  });

  ConversationsModel.fromJson(dynamic json) {
    id = json['id'];
    otherUser = json['other_user'] != null
        ? CustomerModel.fromJson(json['other_user'])
        : null;
    latestMessage = json['latest_message'] != null
        ? MessageModel.fromJson(json['latest_message'])
        : null;
    unseenCount = json['unseen_count'];
    updatedAt = json['updated_at'];
    updatedAtHuman = json['updated_at_human'];
  }

  num? id;
  CustomerModel? otherUser;
  MessageModel? latestMessage;
  num? unseenCount;
  String? updatedAt;
  String? updatedAtHuman;

  ConversationsModel copyWith({
    num? id,
    CustomerModel? otherUser,
    MessageModel? latestMessage,
    num? unseenCount,
    String? updatedAt,
    String? updatedAtHuman,
  }) => ConversationsModel(
    id: id ?? this.id,
    otherUser: otherUser ?? this.otherUser,
    latestMessage: latestMessage ?? this.latestMessage,
    unseenCount: unseenCount ?? this.unseenCount,
    updatedAt: updatedAt ?? this.updatedAt,
    updatedAtHuman: updatedAtHuman ?? this.updatedAtHuman,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (otherUser != null) {
      map['other_user'] = otherUser?.toJson();
    }
    if (latestMessage != null) {
      map['latest_message'] = latestMessage?.toJson();
    }
    map['unseen_count'] = unseenCount;
    map['updated_at'] = updatedAt;
    map['updated_at_human'] = updatedAtHuman;
    return map;
  }
}
