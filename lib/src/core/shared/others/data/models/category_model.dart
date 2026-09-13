/// id : 2
/// name : "أستثمار"
/// slug : "investment"

class CategoryModel {
  CategoryModel({this.id, this.name, this.slug});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }
  num? id;
  String? name;
  String? slug;
  CategoryModel copyWith({num? id, String? name, String? slug}) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    return map;
  }
}
