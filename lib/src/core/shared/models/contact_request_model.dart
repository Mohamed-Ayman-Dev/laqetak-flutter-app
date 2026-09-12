import 'dart:convert';

class ContactRequestModel {
  final int? adId;
  final int? contactRequestId;
  final int? requestedById;
  final String? status;

  ContactRequestModel({
    this.adId,
    this.contactRequestId,
    this.requestedById,
    this.status,
  });

  factory ContactRequestModel.fromJson(dynamic json) {
    if (json is String) {
      json = jsonDecode(json);
    }

    return ContactRequestModel(
      adId: json['ad_id'],
      contactRequestId: json['contact_request_id'],
      requestedById: json['requested_by_id'],
      status: json['status'],
    );
  }
}
