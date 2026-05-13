/// url : "assets/images/dsadsa.jpg"
/// source : "assets"

class AppPhoto {
  AppPhoto({
    this.url,
    this.source,
  });

  AppPhoto.fromJson(dynamic json) {
    url = json['url'];
    source = json['source'];
  }
  String? url;
  String? source;
  AppPhoto copyWith({
    String? url,
    String? source,
  }) =>
      AppPhoto(
        url: url ?? this.url,
        source: source ?? this.source,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['source'] = source;
    return map;
  }
}
