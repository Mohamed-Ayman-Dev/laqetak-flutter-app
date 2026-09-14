import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';

enum ComplaintTarget { ad, customer }

class AdsState extends Equatable {
  const AdsState({
    this.ads,
    this.adsStatus = RequestStatus.initial,
    this.loadingSearch = false,
    this.favAds,
    this.favAdsStatus = RequestStatus.initial,
    this.adDetails = const {},
    this.adDetailsStatus = RequestStatus.initial,
    this.filters = const {},
    this.complaintStatus = RequestStatus.initial,
    this.complaintTarget = ComplaintTarget.ad,
    this.favoriteEventId = 0,
    this.favoriteTitle,
    this.favoriteAdded,
    this.errorMessage,
  });

  final PaginationList<AdModel>? ads;
  final RequestStatus adsStatus;
  final bool loadingSearch;
  final PaginationList<AdModel>? favAds;
  final RequestStatus favAdsStatus;
  final Map<num, AdModel> adDetails;
  final RequestStatus adDetailsStatus;
  final Map<String, dynamic> filters;
  final RequestStatus complaintStatus;
  final ComplaintTarget complaintTarget;
  final int favoriteEventId;
  final String? favoriteTitle;
  final bool? favoriteAdded;
  final String? errorMessage;

  bool get hasAdsError => adsStatus == RequestStatus.error;

  bool get hasFavAdsError => favAdsStatus == RequestStatus.error;

  bool get hasAdDetailsError => adDetailsStatus == RequestStatus.error;

  AdsState copyWith({
    PaginationList<AdModel>? ads,
    RequestStatus? adsStatus,
    bool? loadingSearch,
    PaginationList<AdModel>? favAds,
    RequestStatus? favAdsStatus,
    Map<num, AdModel>? adDetails,
    RequestStatus? adDetailsStatus,
    Map<String, dynamic>? filters,
    RequestStatus? complaintStatus,
    ComplaintTarget? complaintTarget,
    int? favoriteEventId,
    String? favoriteTitle,
    bool? favoriteAdded,
    String? errorMessage,
    bool clearAds = false,
    bool clearFavAds = false,
  }) => AdsState(
    ads: clearAds ? null : (ads ?? this.ads),
    adsStatus: adsStatus ?? this.adsStatus,
    loadingSearch: loadingSearch ?? this.loadingSearch,
    favAds: clearFavAds ? null : (favAds ?? this.favAds),
    favAdsStatus: favAdsStatus ?? this.favAdsStatus,
    adDetails: adDetails ?? this.adDetails,
    adDetailsStatus: adDetailsStatus ?? this.adDetailsStatus,
    filters: filters ?? this.filters,
    complaintStatus: complaintStatus ?? this.complaintStatus,
    complaintTarget: complaintTarget ?? this.complaintTarget,
    favoriteEventId: favoriteEventId ?? this.favoriteEventId,
    favoriteTitle: favoriteTitle ?? this.favoriteTitle,
    favoriteAdded: favoriteAdded ?? this.favoriteAdded,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    ads,
    adsStatus,
    loadingSearch,
    favAds,
    favAdsStatus,
    adDetails,
    adDetailsStatus,
    filters,
    complaintStatus,
    complaintTarget,
    favoriteEventId,
    favoriteTitle,
    favoriteAdded,
    errorMessage,
  ];
}
