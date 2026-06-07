/// id : 10
/// name : "عقاري"

class SectorModel {
  SectorModel({this.id, this.name});

  SectorModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  num? id;
  String? name;

  SectorModel copyWith({num? id, String? name}) =>
      SectorModel(id: id ?? this.id, name: name ?? this.name);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
