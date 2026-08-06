import '../../helpers/others_helper.dart';

/// id : 14
/// name : "الرياض"

class DetailsModel {
  DetailsModel({
    this.id,
    this.name,
    this.image,
    this.code,
    this.key,
    this.requiresAdditionalInfo,
  });

  DetailsModel.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    key = json['key'];

    name = json['name'] is Map<String, dynamic>
        ? (isArabic ? json['name']['ar'] : json['name']['en'])
        : json['name'];
    image = json['image'] ?? json['photo'];
    requiresAdditionalInfo = json['requires_additional_info'];
  }

  num? id;
  String? name;
  String? image;
  String? code;
  String? key;
  bool? requiresAdditionalInfo;

  DetailsModel copyWith({
    num? id,
    String? name,
    String? image,
    String? code,
    String? key,
    bool? requiresAdditionalInfo,
  }) => DetailsModel(
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    image: image ?? this.image,
    key: key ?? this.key,
    requiresAdditionalInfo:
        requiresAdditionalInfo ?? this.requiresAdditionalInfo,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['code'] = code;
    map['requires_additional_info'] = requiresAdditionalInfo;

    map['key'] = key;
    return map;
  }
}
