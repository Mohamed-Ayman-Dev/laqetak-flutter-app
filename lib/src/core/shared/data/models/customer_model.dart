/// id : 35
/// name : "Karim Taha"
/// email : "karimtaha494@gmail.com"
/// avatar : "https://invastro.dev4.wady.sa/storage/5/6a1ed9e365f7d_person1.jpeg"

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
