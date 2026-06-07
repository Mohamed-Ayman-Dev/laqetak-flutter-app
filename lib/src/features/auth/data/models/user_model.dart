import 'package:invastro/src/core/shared/models/details_model.dart';

/// id : 31
/// name : "John Cuza"
/// email : "test@test.com"
/// phone : "0581687277"
/// avatar : "https://invastro.dev4.wady.sa/no-image.png"
/// city : {"id":1,"name":"الحدود الشمالية"}
/// token : "dasdasads"
/// created_at : "2026-05-18T18:19:47.000000Z"

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.notificationCount,
    this.city,
    this.token,
    this.createdAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    city = json['city'] != null ? DetailsModel.fromJson(json['city']) : null;
    token = json['token'];
    notificationCount = json['notification_count'];
    createdAt = json['created_at'];
  }

  num? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;
  DetailsModel? city;
  String? token;
  String? createdAt;
  num? notificationCount;

  UserModel copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    DetailsModel? city,
    String? token,
    num? notificationCount,
    String? createdAt,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    avatar: avatar ?? this.avatar,
    city: city ?? this.city,
    token: token ?? this.token,
    notificationCount: notificationCount ?? this.notificationCount,
    createdAt: createdAt ?? this.createdAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['avatar'] = avatar;
    if (city != null) {
      map['city'] = city?.toJson();
    }
    map['notification_count'] = notificationCount;

    map['token'] = token;
    map['created_at'] = createdAt;
    return map;
  }
}
