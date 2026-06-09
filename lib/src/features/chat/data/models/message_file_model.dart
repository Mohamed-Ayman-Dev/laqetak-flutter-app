/// id : 28
/// name : "rrrr"
/// url : "https://invastro.dev4.wady.sa/storage/28/rrrr.png"
/// preview : "https://invastro.dev4.wady.sa/storage/28/conversions/rrrr-preview.jpg"

class MessageFileModel {
  MessageFileModel({
    this.id,
    this.name,
    this.original,
    this.preview,
    this.thumb,
    this.isFile = false,
  });

  factory MessageFileModel.fromJson(dynamic json) {
    return MessageFileModel(
      id: json['id'],
      name: json['name'],
      original: json['url'],
      preview: json['preview'],
      thumb: json['preview'],
      isFile: json['isAsset'] ?? false,
    );
  }

  num? id;
  String? name;
  String? original;
  String? preview;
  String? thumb;
  late bool isFile;

  MessageFileModel copyWith({
    num? id,
    String? name,
    String? url,
    String? preview,
    String? thumb,
  }) => MessageFileModel(
    id: id ?? this.id,
    name: name ?? this.name,
    original: url ?? this.original,
    preview: preview ?? this.preview,
    thumb: thumb ?? this.thumb,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': original,
      'preview': preview,
      'thumb': thumb,
    };
  }
}
