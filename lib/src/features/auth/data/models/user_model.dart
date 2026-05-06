import 'package:equatable/equatable.dart';

/// id : 33
/// name : "gggg"
/// phone : "0581687277"
/// email : "fcc@gjm.hj"
/// city : {"id":34,"name":"السليل"}
/// photo : "http://ghiar-tech.dev4.wady.sa/storage/37/image_cropper_1765778969411.jpg"
/// default_car : {"id":31,"car_brand":{"id":36,"name":"دودج","photo":"https://ghiar-tech.dev4.wady.sa/no-image.png"},"car_model":{"id":216,"name":"نيون"},"photo":"http://ghiar-tech.dev4.wady.sa/storage/9/image_cropper_1764378379797.jpg","year":"2018","chassis_num":"tfgfg","serial_num":"ggg","is_default":1}
/// default_address : {"id":36,"name":"ujuu","region":{"id":7,"name":"المدينة المنورة"},"city":{"id":39,"name":"خيبر"},"district":"jju","address":"ooo","lat":"24.713797","lng":"46.67548","is_default":1}
/// token : "33|DA9pDJyOGAIoAPa6JeX49lYKtimuUP87Vbu7b13ea68e5061"

class UserModel extends Equatable {
  const UserModel({
    this.id,
    this.name,
    this.username,
    this.phone,
    this.email,
    // this.city,
    this.photo,
    // this.defaultCar,
    // this.defaultAddress,
    this.token,
    this.notificationCount,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['user_name'] ?? json['username'],
      phone: json['phone'],
      email: json['email'],
      // city : json['city'] != null ? DetailsModel.fromJson(json['city']) : null,
      photo: json['photo'],
      // defaultCar : json['default_car'] != null
      //     ? CarModel.fromJson(json['default_car'])
      //     : null,
      // defaultAddress : json['default_address'] != null
      //     ? AddressModel.fromJson(json['default_address'])
      //     : null,
      token: json['token'],
      notificationCount: json['notification_count'] is String
          ? num.tryParse(json['notification_count'])
          : json['notification_count'],
    );
  }

  final num? id;
  final String? name;
  final String? username;
  final String? phone;
  final String? email;

  // DetailsModel? city;
  final String? photo;

  // CarModel? defaultCar;
  // AddressModel? defaultAddress;
  final String? token;
  final num? notificationCount;

  UserModel copyWith({
    num? id,
    String? name,
    String? username,
    String? phone,
    String? email,
    // DetailsModel? city,
    String? photo,
    // CarModel? defaultCar,
    // AddressModel? defaultAddress,
    String? token,
    num? notificationCount,
  }) => UserModel(
    id: id ?? this.id,
    name: name ?? this.name,
    username: username ?? this.username,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    // city: city ?? this.city,
    photo: photo ?? this.photo,
    // defaultCar: defaultCar ?? this.defaultCar,
    // defaultAddress: defaultAddress ?? this.defaultAddress,
    token: token ?? this.token,
    notificationCount: notificationCount ?? this.notificationCount,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['user_name'] = username;
    map['phone'] = phone;
    map['email'] = email;
    // if (city != null) {
    //   map['city'] = city?.toJson();
    // }
    map['photo'] = photo;
    // if (defaultCar != null) {
    //   map['default_car'] = defaultCar?.toJson();
    // }
    // if (defaultAddress != null) {
    //   map['default_address'] = defaultAddress?.toJson();
    // }
    map['token'] = token;
    map['notification_count'] = notificationCount;

    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
    username,
    phone,
    email,
    // city,
    photo,
    // defaultCar,
    // defaultAddress,
    token,
    notificationCount,
  ];
}
