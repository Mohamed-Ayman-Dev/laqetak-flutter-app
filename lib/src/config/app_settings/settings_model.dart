/// about_us : "ssss"
/// terms_and_conditions : "Terms And Conditions"
/// about_us_seller : "About Us Seller"
/// terms_and_conditions_seller : "Terms And Conditions Seller"
/// current_stage : "1"
/// seller_view_address : "ss"
/// seller_view_phone : "ss"
/// social_media : {"facebook":"https://www.facebook.com/g-tech","instagram":"https://www.instagram.com/g-tech","twitter":"https://www.twitter.com/g-tech","youtube":"https://www.youtube.com/g-tech","tiktok":"https://www.tiktok.com/g-tech","linkedin":"https://www.linkedin.com/g-tech","pinterest":"https://www.pinterest.com/g-tech","telegram":"https://www.telegram.com/g-tech","snapchat":"https://www.snapchat.com/g-tech","whatsapp":"https://www.whatsapp.com/g-tech"}

class SettingsModel {
  SettingsModel({
    this.aboutUs,
    this.termsAndConditions,
    this.aboutUsSeller,
    this.termsAndConditionsSeller,
    this.contactPhone,
    this.contactPhoneSeller,
    this.sellerVisabilityDataForVisitors,

    this.currentStage,
    this.sellerViewAddress,
    this.sellerViewPhone,
    this.socialMedia,
  });

  SettingsModel.fromJson(dynamic json) {
    aboutUs = json['about_us'];
    termsAndConditions = json['terms_and_conditions'];
    aboutUsSeller = json['about_us_seller'];
    termsAndConditionsSeller = json['terms_and_conditions_seller'];
    currentStage = json['current_stage'];
    sellerViewAddress = json['seller_view_address'];
    sellerViewPhone = json['seller_view_phone'];
    socialMedia = json['social_media'] != null
        ? SocialMedia.fromJson(json['social_media'])
        : null;
    contactPhone = json['contact_phone'];
    contactPhoneSeller = json['contact_phone_seller'];
    if (json['seller_visability_data_for_visitors'] != null) {
      sellerVisabilityDataForVisitors = [];
      json['seller_visability_data_for_visitors'].forEach((v) {
        sellerVisabilityDataForVisitors?.add(v);
      });
    }
  }

  String? aboutUs;
  String? termsAndConditions;
  String? aboutUsSeller;
  String? termsAndConditionsSeller;
  String? currentStage;
  String? sellerViewAddress;
  String? sellerViewPhone;
  String? contactPhone;
  String? contactPhoneSeller;
  List<String>? sellerVisabilityDataForVisitors;
  SocialMedia? socialMedia;

  SettingsModel copyWith({
    String? aboutUs,
    String? termsAndConditions,
    String? aboutUsSeller,
    String? termsAndConditionsSeller,
    String? currentStage,
    String? sellerViewAddress,
    String? sellerViewPhone,
    List<String>? sellerVisabilityDataForVisitors,
    String? contactPhone,
    String? contactPhoneSeller,
    SocialMedia? socialMedia,
  }) => SettingsModel(
    aboutUs: aboutUs ?? this.aboutUs,
    termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    aboutUsSeller: aboutUsSeller ?? this.aboutUsSeller,
    termsAndConditionsSeller:
        termsAndConditionsSeller ?? this.termsAndConditionsSeller,
    currentStage: currentStage ?? this.currentStage,
    sellerViewAddress: sellerViewAddress ?? this.sellerViewAddress,
    sellerViewPhone: sellerViewPhone ?? this.sellerViewPhone,
    socialMedia: socialMedia ?? this.socialMedia,
    contactPhone: contactPhone ?? this.contactPhone,
    contactPhoneSeller: contactPhoneSeller ?? this.contactPhoneSeller,
    sellerVisabilityDataForVisitors:
        sellerVisabilityDataForVisitors ?? this.sellerVisabilityDataForVisitors,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['about_us'] = aboutUs;
    map['terms_and_conditions'] = termsAndConditions;
    map['about_us_seller'] = aboutUsSeller;
    map['terms_and_conditions_seller'] = termsAndConditionsSeller;
    map['current_stage'] = currentStage;
    map['seller_view_address'] = sellerViewAddress;
    map['seller_view_phone'] = sellerViewPhone;
    map['contact_phone'] = contactPhone;
    map['contact_phone_seller'] = contactPhoneSeller;

    if (socialMedia != null) {
      map['social_media'] = socialMedia?.toJson();
    }
    return map;
  }
}

/// facebook : "https://www.facebook.com/g-tech"
/// instagram : "https://www.instagram.com/g-tech"
/// twitter : "https://www.twitter.com/g-tech"
/// youtube : "https://www.youtube.com/g-tech"
/// tiktok : "https://www.tiktok.com/g-tech"
/// linkedin : "https://www.linkedin.com/g-tech"
/// pinterest : "https://www.pinterest.com/g-tech"
/// telegram : "https://www.telegram.com/g-tech"
/// snapchat : "https://www.snapchat.com/g-tech"
/// whatsapp : "https://www.whatsapp.com/g-tech"

class SocialMedia {
  SocialMedia({
    this.facebook,
    this.instagram,
    this.twitter,
    this.youtube,
    this.tiktok,
    this.linkedin,
    this.pinterest,
    this.telegram,
    this.snapchat,
    this.whatsapp,
  });

  SocialMedia.fromJson(dynamic json) {
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    youtube = json['youtube'];
    tiktok = json['tiktok'];
    linkedin = json['linkedin'];
    pinterest = json['pinterest'];
    telegram = json['telegram'];
    snapchat = json['snapchat'];
    whatsapp = json['whatsapp'];
  }

  String? facebook;
  String? instagram;
  String? twitter;
  String? youtube;
  String? tiktok;
  String? linkedin;
  String? pinterest;
  String? telegram;
  String? snapchat;
  String? whatsapp;

  SocialMedia copyWith({
    String? facebook,
    String? instagram,
    String? twitter,
    String? youtube,
    String? tiktok,
    String? linkedin,
    String? pinterest,
    String? telegram,
    String? snapchat,
    String? whatsapp,
  }) => SocialMedia(
    facebook: facebook ?? this.facebook,
    instagram: instagram ?? this.instagram,
    twitter: twitter ?? this.twitter,
    youtube: youtube ?? this.youtube,
    tiktok: tiktok ?? this.tiktok,
    linkedin: linkedin ?? this.linkedin,
    pinterest: pinterest ?? this.pinterest,
    telegram: telegram ?? this.telegram,
    snapchat: snapchat ?? this.snapchat,
    whatsapp: whatsapp ?? this.whatsapp,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = facebook;
    map['instagram'] = instagram;
    map['twitter'] = twitter;
    map['youtube'] = youtube;
    map['tiktok'] = tiktok;
    map['linkedin'] = linkedin;
    map['pinterest'] = pinterest;
    map['telegram'] = telegram;
    map['snapchat'] = snapchat;
    map['whatsapp'] = whatsapp;
    return map;
  }
}
