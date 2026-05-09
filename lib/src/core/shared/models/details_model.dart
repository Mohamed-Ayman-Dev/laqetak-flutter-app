import '../../helpers/others_helper.dart';

/// id : 14
/// name : "الرياض"

class DetailsModel {
  DetailsModel({this.id, this.name, this.image, this.code, this.key});

  DetailsModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    key = json['key'];

    name = json['name'] is Map<String, dynamic>
        ? (isArabic ? json['name']['ar'] : json['name']['en'])
        : json['name'];
    image = json['image'] ?? json['photo'];
  }

  num? id;
  String? name;
  String? image;
  String? code;
  String? key;

  DetailsModel copyWith({
    num? id,
    String? name,
    String? image,
    String? code,
    String? key,
  }) => DetailsModel(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    image: image ?? this.image,
    key: key ?? this.key,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['code'] = code;
    map['key'] = key;
    return map;
  }
}
