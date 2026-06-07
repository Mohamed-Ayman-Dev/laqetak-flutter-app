/// id : 17
/// name : "a4a08a44e954050e9940aa09470bca9c6fc4c0f6 (1)"
/// url : "https://invastro.dev4.wady.sa/storage/17/a4a08a44e954050e9940aa09470bca9c6fc4c0f6-(1).jpg"
/// preview : "https://invastro.dev4.wady.sa/storage/17/conversions/a4a08a44e954050e9940aa09470bca9c6fc4c0f6-(1)-preview.jpg"

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
