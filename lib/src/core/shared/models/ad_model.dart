import 'package:invastro/src/core/shared/models/category_model.dart';
import 'package:invastro/src/core/shared/models/customer_model.dart';
import 'package:invastro/src/core/shared/models/details_model.dart';
import 'package:invastro/src/core/shared/models/photo_model.dart';
import 'package:invastro/src/core/shared/models/sector_model.dart';

/// id : 63
/// title : "مشروع تجاري كامل"
/// description : "محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد."
/// investment_amount : "50000.00"
/// views_count : 1
/// contact_phone : "0512345611"
/// hide_phone : 0
/// status : "publish"
/// is_favorite : false
/// category : {"id":2,"name":"أستثمار","slug":"investment"}
/// sector : {"id":10,"name":"عقاري"}
/// city : {"id":6,"name":"الرياض"}
/// customer : {"id":35,"name":"Karim Taha","email":"karimtaha494@gmail.com","avatar":"https://invastro.dev4.wady.sa/storage/5/6a1ed9e365f7d_person1.jpeg"}
/// photos : [{"id":17,"name":"a4a08a44e954050e9940aa09470bca9c6fc4c0f6 (1)","url":"https://invastro.dev4.wady.sa/storage/17/a4a08a44e954050e9940aa09470bca9c6fc4c0f6-(1).jpg","preview":"https://invastro.dev4.wady.sa/storage/17/conversions/a4a08a44e954050e9940aa09470bca9c6fc4c0f6-(1)-preview.jpg"}]
/// published_at : "4 دقائق"

class AdModel {
  AdModel({
    this.id,
    this.title,
    this.description,
    this.investmentAmount,
    this.viewsCount,
    this.contactPhone,
    this.hidePhone,
    this.status,
    this.isFavorite,
    this.category,
    this.sector,
    this.city,
    this.customer,
    this.photos,
    this.contactRequestStatus,
    this.mainPhoto,
    this.publishedAt,
  });

  AdModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    investmentAmount = json['investment_amount']?.toString();
    viewsCount = json['views_count'];
    contactPhone = json['contact_phone'];
    hidePhone = json['hide_phone'] == null
        ? null
        : json['hide_phone'] is String
        ? (json['hide_phone'] == 'true' ? 1 : 0)
        : json['hide_phone'] is bool
        ? (json['hide_phone'] == true ? 1 : 0)
        : json['hide_phone'];
    contactRequestStatus = json['contact_request_status'];
    status = json['status'];
    isFavorite = json['is_favorite'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    sector = json['sector'] != null
        ? SectorModel.fromJson(json['sector'])
        : null;
    city = json['city'] != null ? DetailsModel.fromJson(json['city']) : null;
    customer = json['customer'] != null
        ? CustomerModel.fromJson(json['customer'])
        : null;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(PhotoModel.fromJson(v));
      });
    }
    mainPhoto = json['main_photo'];
    publishedAt = json['published_at'];
  }

  num? id;
  String? title;
  String? mainPhoto;
  String? description;
  String? investmentAmount;
  num? viewsCount;
  String? contactPhone;
  String? contactRequestStatus;
  num? hidePhone;
  String? status;
  bool? isFavorite;
  CategoryModel? category;
  SectorModel? sector;
  DetailsModel? city;
  CustomerModel? customer;
  List<PhotoModel>? photos;
  String? publishedAt;

  AdModel copyWith({
    num? id,
    String? title,
    String? description,
    String? investmentAmount,
    num? viewsCount,
    String? contactPhone,
    num? hidePhone,
    String? status,
    bool? isFavorite,
    String? mainPhoto,
    String? contactRequestStatus,
    CategoryModel? category,
    SectorModel? sector,
    DetailsModel? city,
    CustomerModel? customer,
    List<PhotoModel>? photos,
    String? publishedAt,
  }) => AdModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    investmentAmount: investmentAmount ?? this.investmentAmount,
    viewsCount: viewsCount ?? this.viewsCount,
    contactPhone: contactPhone ?? this.contactPhone,
    contactRequestStatus: contactRequestStatus ?? this.contactRequestStatus,
    hidePhone: hidePhone ?? this.hidePhone,
    mainPhoto: mainPhoto ?? this.mainPhoto,
    status: status ?? this.status,
    isFavorite: isFavorite ?? this.isFavorite,
    category: category ?? this.category,
    sector: sector ?? this.sector,
    city: city ?? this.city,
    customer: customer ?? this.customer,
    photos: photos ?? this.photos,
    publishedAt: publishedAt ?? this.publishedAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['investment_amount'] = investmentAmount;
    map['views_count'] = viewsCount;
    map['contact_phone'] = contactPhone;
    map['contact_request_status'] = contactRequestStatus;
    map['hide_phone'] = hidePhone;
    map['status'] = status;
    map['is_favorite'] = isFavorite;
    map['main_photo'] = mainPhoto;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (sector != null) {
      map['sector'] = sector?.toJson();
    }
    if (city != null) {
      map['city'] = city?.toJson();
    }
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['published_at'] = publishedAt;
    return map;
  }
}
