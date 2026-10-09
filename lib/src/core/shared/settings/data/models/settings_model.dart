/// contact_email : "support@example.com"
/// contact_phone : "+961 70 000 000"
/// cost_per_ad : "50"
/// idea_of_company : "فكرة المنصة هي الربط بين أصحاب الأفكـــار وأصحـــاب رؤوس الأموال , بناء على ذلك فإن المنصة تقوم بإخلاء  مسؤوليتها تماماً  من سرقة الأ فكار"
/// about_us : "About Us"
/// terms_and_conditions : "الشروط والأحكام، محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد.محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد. محتوى تجريبي يمكن استبداله فيما بعد."
/// facebook : "https://www.facebook.com/example"
/// instagram : "https://www.instagram.com/example"
/// twitter : "https://www.twitter.com/example"
/// linkedin : "https://www.linkedin.com/example"
/// youtube : "https://www.youtube.com/example"
/// tiktok : "https://www.tiktok.com/example"
/// snapchat : "https://www.snapchat.com/example"
/// whatsapp : "https://www.whatsapp.com/example"

class SettingsModel {
  SettingsModel({
    this.contactEmail,
    this.contactPhone,
    this.costPerAd,
    this.ideaOfCompany,
    this.aboutUs,
    this.termsAndConditions,
    this.facebook,
    this.instagram,
    this.twitter,
    this.linkedin,
    this.youtube,
    this.tiktok,
    this.snapchat,
    this.whatsapp,
  });

  SettingsModel.fromJson(dynamic json) {
    contactEmail = json['contact_email'];
    contactPhone = json['contact_phone'];
    costPerAd = json['cost_per_ad'];
    ideaOfCompany = json['idea_of_company'];
    aboutUs = json['about_us'];
    termsAndConditions = json['terms_and_conditions'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
    tiktok = json['tiktok'];
    snapchat = json['snapchat'];
    whatsapp = json['whatsapp'];
  }
  String? contactEmail;
  String? contactPhone;
  String? costPerAd;
  String? ideaOfCompany;
  String? aboutUs;
  String? termsAndConditions;
  String? facebook;
  String? instagram;
  String? twitter;
  String? linkedin;
  String? youtube;
  String? tiktok;
  String? snapchat;
  String? whatsapp;
  SettingsModel copyWith({
    String? contactEmail,
    String? contactPhone,
    String? costPerAd,
    String? ideaOfCompany,
    String? aboutUs,
    String? termsAndConditions,
    String? facebook,
    String? instagram,
    String? twitter,
    String? linkedin,
    String? youtube,
    String? tiktok,
    String? snapchat,
    String? whatsapp,
  }) => SettingsModel(
    contactEmail: contactEmail ?? this.contactEmail,
    contactPhone: contactPhone ?? this.contactPhone,
    costPerAd: costPerAd ?? this.costPerAd,
    ideaOfCompany: ideaOfCompany ?? this.ideaOfCompany,
    aboutUs: aboutUs ?? this.aboutUs,
    termsAndConditions: termsAndConditions ?? this.termsAndConditions,
    facebook: facebook ?? this.facebook,
    instagram: instagram ?? this.instagram,
    twitter: twitter ?? this.twitter,
    linkedin: linkedin ?? this.linkedin,
    youtube: youtube ?? this.youtube,
    tiktok: tiktok ?? this.tiktok,
    snapchat: snapchat ?? this.snapchat,
    whatsapp: whatsapp ?? this.whatsapp,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['contact_email'] = contactEmail;
    map['contact_phone'] = contactPhone;
    map['cost_per_ad'] = costPerAd;
    map['idea_of_company'] = ideaOfCompany;
    map['about_us'] = aboutUs;
    map['terms_and_conditions'] = termsAndConditions;
    map['facebook'] = facebook;
    map['instagram'] = instagram;
    map['twitter'] = twitter;
    map['linkedin'] = linkedin;
    map['youtube'] = youtube;
    map['tiktok'] = tiktok;
    map['snapchat'] = snapchat;
    map['whatsapp'] = whatsapp;
    return map;
  }
}
