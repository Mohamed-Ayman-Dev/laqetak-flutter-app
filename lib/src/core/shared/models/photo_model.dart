/// id : 17
/// name : "photo"
/// url : "https://example.com/storage/17/photo.jpg"
/// preview : "https://example.com/storage/17/conversions/photo-preview.jpg"

class PhotoModel {
  PhotoModel({this.id, this.name, this.url, this.preview, this.source});

  PhotoModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    preview = json['preview'];
    source = json['source'];
  }

  num? id;
  String? name;
  String? url;
  String? preview;
  String? source;

  PhotoModel copyWith({
    num? id,
    String? name,
    String? url,
    String? source,
    String? preview,
  }) => PhotoModel(
    id: id ?? this.id,
    name: name ?? this.name,
    url: url ?? this.url,
    preview: preview ?? this.preview,
    source: source ?? this.source,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['preview'] = preview;
    map['source'] = source;

    return map;
  }
}
