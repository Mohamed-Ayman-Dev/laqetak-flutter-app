/// id : 28
/// name : "rrrr"
/// url : "https://invastro.dev4.wady.sa/storage/28/rrrr.png"
/// preview : "https://invastro.dev4.wady.sa/storage/28/conversions/rrrr-preview.jpg"

class FileModel {
  FileModel({this.id, this.name, this.url, this.preview});

  FileModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    preview = json['preview'];
  }

  num? id;
  String? name;
  String? url;
  String? preview;

  FileModel copyWith({num? id, String? name, String? url, String? preview}) =>
      FileModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        preview: preview ?? this.preview,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['url'] = url;
    map['preview'] = preview;
    return map;
  }
}
