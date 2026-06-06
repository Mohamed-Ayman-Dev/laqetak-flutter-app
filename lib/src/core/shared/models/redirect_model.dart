/// redirect : "register-otp"
/// customer_id : 31
/// phone : "0581687277"
/// remainingSeconds : 119

class RedirectModel {
  RedirectModel({
    this.redirect,
    this.customerId,
    this.phone,
    this.remainingSeconds,
  });

  RedirectModel.fromJson(dynamic json) {
    redirect = json['redirect'];
    customerId = json['customer_id'];
    phone = json['phone'];
    remainingSeconds = json['remainingSeconds'];
  }

  String? redirect;
  num? customerId;
  String? phone;
  num? remainingSeconds;

  RedirectModel copyWith({
    String? redirect,
    num? customerId,
    String? phone,
    num? remainingSeconds,
  }) => RedirectModel(
    redirect: redirect ?? this.redirect,
    customerId: customerId ?? this.customerId,
    phone: phone ?? this.phone,
    remainingSeconds: remainingSeconds ?? this.remainingSeconds,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redirect'] = redirect;
    map['customer_id'] = customerId;
    map['phone'] = phone;
    map['remainingSeconds'] = remainingSeconds;
    return map;
  }
}
