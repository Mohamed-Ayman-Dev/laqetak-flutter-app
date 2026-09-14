import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

class AdDetailsState extends Equatable {
  const AdDetailsState({
    this.customerAds = const {},
    this.customerAdsStatus = const {},
    this.phoneRequestStatus = RequestStatus.initial,
    this.hidePhoneEventId = 0,
    this.hidePhoneEnabled = false,
    this.actionErrorEventId = 0,
    this.errorMessage,
  });

  final Map<num, PaginationList<AdModel>> customerAds;
  final Map<num, RequestStatus> customerAdsStatus;
  final RequestStatus phoneRequestStatus;
  final int hidePhoneEventId;
  final bool hidePhoneEnabled;
  final int actionErrorEventId;
  final String? errorMessage;

  bool hasCustomerAdsError(num customerId) =>
      customerAdsStatus[customerId] == RequestStatus.error;

  AdDetailsState copyWith({
    Map<num, PaginationList<AdModel>>? customerAds,
    Map<num, RequestStatus>? customerAdsStatus,
    RequestStatus? phoneRequestStatus,
    int? hidePhoneEventId,
    bool? hidePhoneEnabled,
    int? actionErrorEventId,
    String? errorMessage,
  }) => AdDetailsState(
    customerAds: customerAds ?? this.customerAds,
    customerAdsStatus: customerAdsStatus ?? this.customerAdsStatus,
    phoneRequestStatus: phoneRequestStatus ?? this.phoneRequestStatus,
    hidePhoneEventId: hidePhoneEventId ?? this.hidePhoneEventId,
    hidePhoneEnabled: hidePhoneEnabled ?? this.hidePhoneEnabled,
    actionErrorEventId: actionErrorEventId ?? this.actionErrorEventId,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    customerAds,
    customerAdsStatus,
    phoneRequestStatus,
    hidePhoneEventId,
    hidePhoneEnabled,
    actionErrorEventId,
    errorMessage,
  ];
}
