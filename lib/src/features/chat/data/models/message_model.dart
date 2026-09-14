import 'package:invastro/src/core/di/locator_service.dart';
import 'package:invastro/src/features/chat/data/models/message_file_model.dart';

import '../../../../core/constants/enums.dart';
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
    this.isTemp = false,
    this.status = MessageStatus.sent,
  });

  factory MessageModel.fromJson(dynamic json) {
    return MessageModel(
      id: json['id'],
      message: json['message'],
      files: json['files'] != null
          ? (json['files'] as List)
                .map((file) => MessageFileModel.fromJson(file))
                .toList()
          : null,
      isMine: json['is_mine'],
      isSeen: json['is_seen'],
      seenAt: json['seen_at'],
      seenAtHuman: json['seen_at_human'],
      sender: json['sender'] != null
          ? CustomerModel.fromJson(json['sender'])
          : null,
      createdAt: json['created_at'],
      createdAtHuman: json['created_at_human'],
      status: MessageStatus.sent,
      isTemp: json['isTemp'] ?? false,
    );
  }

  factory MessageModel.fromPusher(Map<String, dynamic> json) {
    return MessageModel(
      id: num.tryParse(json['id'].toString()),
      message: json['message'],
      isTemp: json['isTemp'] ?? false,
      isMine:
          num.tryParse(json['customer_id'].toString()) ==
          LocatorService.authCubit.state.user?.id,
      isSeen: json['is_seen'] ?? false,
      seenAt: json['seen_at'],
      createdAt: json['created_at'],
      files: json['files'] != null
          ? (json['files'] as List)
                .map((file) => MessageFileModel.fromJson(file))
                .toList()
          : null,
      status: MessageStatus.sent,
    );
  }

  num? id;
  String? message;
  List<MessageFileModel>? files;
  bool? isMine;
  MessageStatus status;
  late bool isTemp;
  bool? isSeen;
  dynamic seenAt;
  dynamic seenAtHuman;
  CustomerModel? sender;
  String? createdAt;
  String? createdAtHuman;

  MessageModel copyWith({
    num? id,
    String? message,
    List<MessageFileModel>? files,
    bool? isMine,
    bool? isSeen,
    dynamic seenAt,
    dynamic seenAtHuman,
    CustomerModel? sender,
    String? createdAt,
    String? createdAtHuman,
    MessageStatus? status,
    bool? isTemp,
  }) => MessageModel(
    id: id ?? this.id,
    message: message ?? this.message,
    files: files ?? this.files,
    isMine: isMine ?? this.isMine,
    isSeen: isSeen ?? this.isSeen,
    seenAt: seenAt ?? this.seenAt,
    seenAtHuman: seenAtHuman ?? this.seenAtHuman,
    isTemp: isTemp ?? this.isTemp,
    status: status ?? this.status,
    sender: sender ?? this.sender,
    createdAt: createdAt ?? this.createdAt,
    createdAtHuman: createdAtHuman ?? this.createdAtHuman,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      if (files != null) 'files': files!.map((v) => v.toJson()).toList(),
      'is_mine': isMine,
      'is_seen': isSeen,
      'seen_at': seenAt,
      'seen_at_human': seenAtHuman,
      if (sender != null) 'sender': sender!.toJson(),
      'created_at': createdAt,
      'created_at_human': createdAtHuman,
    };
  }
}
