/// id : 35
/// name : "John Doe"
/// email : "user@example.com"
/// avatar : "https://example.com/avatar.png"

class CustomerModel {
  CustomerModel({this.id, this.name, this.email, this.avatar});

  CustomerModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
  }

  num? id;
  String? name;
  String? email;
  String? avatar;

  CustomerModel copyWith({
    num? id,
    String? name,
    String? email,
    String? avatar,
  }) => CustomerModel(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    return map;
  }
}
