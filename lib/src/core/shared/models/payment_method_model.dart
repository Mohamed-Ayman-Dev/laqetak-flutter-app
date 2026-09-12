/// id : 1
/// name : "Cash"
/// key : "cash"

class PaymentMethodModel {
  PaymentMethodModel({this.id, this.name, this.key});

  PaymentMethodModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    key = json['key'];
  }
  num? id;
  String? name;
  String? key;
  PaymentMethodModel copyWith({num? id, String? name, String? key}) =>
      PaymentMethodModel(
        id: id ?? this.id,
        name: name ?? this.name,
        key: key ?? this.key,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['key'] = key;
    return map;
  }
}
