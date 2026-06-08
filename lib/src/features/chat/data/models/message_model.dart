import 'package:invastro/src/features/chat/data/models/file_model.dart';

import '../../../../core/shared/models/customer_model.dart';

/// id : 4
/// message : "test"
/// files : [{"id":28,"name":"rrrr","url":"https://invastro.dev4.wady.sa/storage/28/rrrr.png","preview":"https://invastro.dev4.wady.sa/storage/28/conversions/rrrr-preview.jpg"}]
/// is_mine : true
/// is_seen : false
/// seen_at : null
/// seen_at_human : null
/// sender : {"id":31,"name":"John Cuza","avatar":"https://invastro.dev4.wady.sa/no-image.png"}
/// created_at : "2026-06-08T19:21:40.000000Z"
/// created_at_human : "12 ثانية"

class MessageModel {
  MessageModel({
    this.id,
    this.message,
    this.files,
    this.isMine,
    this.isSeen,
    this.seenAt,
    this.seenAtHuman,
    this.sender,
    this.createdAt,
    this.createdAtHuman,
  });

  MessageModel.fromJson(dynamic json) {
    id = json['id'];
    message = json['message'];
    if (json['files'] != null) {
      files = [];
      json['files'].forEach((v) {
        files?.add(FileModel.fromJson(v));
      });
    }
    isMine = json['is_mine'];
    isSeen = json['is_seen'];
    seenAt = json['seen_at'];
    seenAtHuman = json['seen_at_human'];
    sender = json['sender'] != null
        ? CustomerModel.fromJson(json['sender'])
        : null;
    createdAt = json['created_at'];
    createdAtHuman = json['created_at_human'];
  }

  num? id;
  String? message;
  List<FileModel>? files;
  bool? isMine;
  bool? isSeen;
  dynamic seenAt;
  dynamic seenAtHuman;
  CustomerModel? sender;
  String? createdAt;
  String? createdAtHuman;

  MessageModel copyWith({
    num? id,
    String? message,
    List<FileModel>? files,
    bool? isMine,
    bool? isSeen,
    dynamic seenAt,
    dynamic seenAtHuman,
    CustomerModel? sender,
    String? createdAt,
    String? createdAtHuman,
  }) => MessageModel(
    id: id ?? this.id,
    message: message ?? this.message,
    files: files ?? this.files,
    isMine: isMine ?? this.isMine,
    isSeen: isSeen ?? this.isSeen,
    seenAt: seenAt ?? this.seenAt,
    seenAtHuman: seenAtHuman ?? this.seenAtHuman,
    sender: sender ?? this.sender,
    createdAt: createdAt ?? this.createdAt,
    createdAtHuman: createdAtHuman ?? this.createdAtHuman,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['message'] = message;
    if (files != null) {
      map['files'] = files?.map((v) => v.toJson()).toList();
    }
    map['is_mine'] = isMine;
    map['is_seen'] = isSeen;
    map['seen_at'] = seenAt;
    map['seen_at_human'] = seenAtHuman;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    map['created_at'] = createdAt;
    map['created_at_human'] = createdAtHuman;
    return map;
  }
}
