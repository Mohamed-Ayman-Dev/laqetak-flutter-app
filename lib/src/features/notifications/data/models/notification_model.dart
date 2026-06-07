/// id : 1
/// alert_text : "Voluptas id enim ita"
/// alert_body : "Proident ipsum ex l"
/// alert_link : "Perferendis qui cupi"
/// type : "manual"
/// data : null
/// created_at : "أسبوعين"
/// read : 0

class NotificationModel {
  NotificationModel({
      this.id, 
      this.alertText, 
      this.alertBody, 
      this.alertLink, 
      this.type, 
      this.data, 
      this.createdAt, 
      this.read,});

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    alertText = json['alert_text'];
    alertBody = json['alert_body'];
    alertLink = json['alert_link'];
    type = json['type'];
    data = json['data'];
    createdAt = json['created_at'];
    read = json['read'];
  }
  num? id;
  String? alertText;
  String? alertBody;
  String? alertLink;
  String? type;
  dynamic data;
  String? createdAt;
  num? read;
NotificationModel copyWith({  num? id,
  String? alertText,
  String? alertBody,
  String? alertLink,
  String? type,
  dynamic data,
  String? createdAt,
  num? read,
}) => NotificationModel(  id: id ?? this.id,
  alertText: alertText ?? this.alertText,
  alertBody: alertBody ?? this.alertBody,
  alertLink: alertLink ?? this.alertLink,
  type: type ?? this.type,
  data: data ?? this.data,
  createdAt: createdAt ?? this.createdAt,
  read: read ?? this.read,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['alert_text'] = alertText;
    map['alert_body'] = alertBody;
    map['alert_link'] = alertLink;
    map['type'] = type;
    map['data'] = data;
    map['created_at'] = createdAt;
    map['read'] = read;
    return map;
  }

}