/// id : 10
/// name : "عقاري"

class SectorModel {
  SectorModel({this.id, this.name, this.arrange, this.requiresAdditionalInfo});

  SectorModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    arrange = json['arrange'];
    requiresAdditionalInfo = json['requires_additional_info'];
  }

  num? id;
  String? name;

  num? arrange;
  bool? requiresAdditionalInfo;

  SectorModel copyWith({
    num? id,
    String? name,
    num? arrange,
    bool? requiresAdditionalInfo,
  }) => SectorModel(
    id: id ?? this.id,
    name: name ?? this.name,
    arrange: arrange ?? this.arrange,
    requiresAdditionalInfo:
        requiresAdditionalInfo ?? this.requiresAdditionalInfo,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['arrange'] = arrange;
    map['requires_additional_info'] = requiresAdditionalInfo;
    return map;
  }
}
