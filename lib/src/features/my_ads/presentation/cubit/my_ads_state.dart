import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/shared/models/redirect_model.dart';

enum MyAdsMutation { none, add, edit, delete, close, pay, otp }

class MyAdsState extends Equatable {
  const MyAdsState({
    this.ads,
    this.listStatus = RequestStatus.initial,
    this.actionStatus = RequestStatus.initial,
    this.lastMutation = MyAdsMutation.none,
    this.createdAd,
    this.checkoutUrl,
    this.paymentTime,
    this.otpRedirect,
    this.otpMessage,
    this.otpFormData,
    this.otpIsEdit = false,
    this.otpResent = false,
    this.lastAdId,
    this.errorMessage,
    this.verificationErrorMessage,
  });

  final PaginationList<AdModel>? ads;
  final RequestStatus listStatus;
  final RequestStatus actionStatus;
  final MyAdsMutation lastMutation;
  final AdModel? createdAd;
  final String? checkoutUrl;
  final dynamic paymentTime;
  final RedirectModel? otpRedirect;
  final String? otpMessage;
  final Map<String, dynamic>? otpFormData;
  final bool otpIsEdit;
  final bool otpResent;
  final num? lastAdId;
  final String? errorMessage;
  final String? verificationErrorMessage;

  bool get hasListError => listStatus == RequestStatus.error;

  MyAdsState copyWith({
    PaginationList<AdModel>? ads,
    RequestStatus? listStatus,
    RequestStatus? actionStatus,
    MyAdsMutation? lastMutation,
    AdModel? createdAd,
    String? checkoutUrl,
    dynamic paymentTime,
    RedirectModel? otpRedirect,
    String? otpMessage,
    Map<String, dynamic>? otpFormData,
    bool? otpIsEdit,
    bool? otpResent,
    num? lastAdId,
    String? errorMessage,
    String? verificationErrorMessage,
    bool clearAds = false,
    bool clearCheckout = false,
    bool clearVerification = false,
  }) => MyAdsState(
    ads: clearAds ? null : (ads ?? this.ads),
    listStatus: listStatus ?? this.listStatus,
    actionStatus: actionStatus ?? this.actionStatus,
    lastMutation: lastMutation ?? this.lastMutation,
    createdAd: createdAd ?? this.createdAd,
    checkoutUrl: clearCheckout ? null : (checkoutUrl ?? this.checkoutUrl),
    paymentTime: paymentTime ?? this.paymentTime,
    otpRedirect: otpRedirect ?? this.otpRedirect,
    otpMessage: otpMessage ?? this.otpMessage,
    otpFormData: otpFormData ?? this.otpFormData,
    otpIsEdit: otpIsEdit ?? this.otpIsEdit,
    otpResent: otpResent ?? this.otpResent,
    lastAdId: lastAdId ?? this.lastAdId,
    errorMessage: errorMessage ?? this.errorMessage,
    verificationErrorMessage: clearVerification
        ? null
        : (verificationErrorMessage ?? this.verificationErrorMessage),
  );

  @override
  List<Object?> get props => [
    ads,
    listStatus,
    actionStatus,
    lastMutation,
    createdAd,
    checkoutUrl,
    paymentTime,
    otpRedirect,
    otpMessage,
    otpFormData,
    otpIsEdit,
    otpResent,
    lastAdId,
    errorMessage,
    verificationErrorMessage,
  ];
}
