import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/ad_details/data/repositories/ad_details_repository.dart';
import 'package:laqetak/src/features/home/presentation/cubit/ads_cubit.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import 'ad_details_state.dart';

class AdDetailsCubit extends BaseCubit<AdDetailsState> {
  AdDetailsCubit(this._adDetailsRepository, this._adsCubit)
    : super(const AdDetailsState());

  final AdDetailsRepository _adDetailsRepository;
  final AdsCubit _adsCubit;

  Future<void> getCustomerAds({required num id, bool refresh = false}) async {
    final current = state.customerAds[id];
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.customerAdsStatus[id] == RequestStatus.loading) return;

    final statuses = Map<num, RequestStatus>.from(state.customerAdsStatus);
    statuses[id] = RequestStatus.loading;
    emit(state.copyWith(customerAdsStatus: statuses));

    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _adDetailsRepository.getCustomerAds(
      customerId: id,
      page: nextPage,
    );
    result.when(
      success: (page) {
        final ads = Map<num, PaginationList<AdModel>>.from(state.customerAds);
        ads[id] = refresh || current == null ? page : _append(current, page);
        final nextStatuses = Map<num, RequestStatus>.from(
          state.customerAdsStatus,
        );
        nextStatuses[id] = RequestStatus.success;
        emit(state.copyWith(customerAds: ads, customerAdsStatus: nextStatuses));
      },
      failure: (error) {
        final nextStatuses = Map<num, RequestStatus>.from(
          state.customerAdsStatus,
        );
        nextStatuses[id] = RequestStatus.error;
        emit(
          state.copyWith(
            customerAdsStatus: nextStatuses,
            errorMessage: error.message,
          ),
        );
      },
    );
  }

  Future<void> toggleHidePhone(AdModel ad) async {
    final newState = ad.hidePhone == 1 ? 0 : 1;
    _adsCubit.setHidePhone(ad.id ?? 0, hide: newState);
    emit(
      state.copyWith(
        hidePhoneEventId: state.hidePhoneEventId + 1,
        hidePhoneEnabled: newState == 1,
      ),
    );
    final result = await _adDetailsRepository.toggleHidePhone(ad.id ?? 0);
    result.when(
      success: (_) {},
      failure: (error) => emit(
        state.copyWith(
          actionErrorEventId: state.actionErrorEventId + 1,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> sendShowPhoneRequest(AdModel ad) async {
    final adId = ad.id;
    if (adId == null) return;
    if (state.phoneRequestStatus == RequestStatus.loading) return;

    emit(state.copyWith(phoneRequestStatus: RequestStatus.loading));
    final result = await _adDetailsRepository.sendShowPhoneRequest(adId);
    if (result.isFailure) {
      emit(
        state.copyWith(
          phoneRequestStatus: RequestStatus.error,
          actionErrorEventId: state.actionErrorEventId + 1,
          errorMessage: result.errorOrNull?.message,
        ),
      );
      return;
    }
    await _adsCubit.getAdDetails(adId);
    emit(state.copyWith(phoneRequestStatus: RequestStatus.success));
  }

  void clearPhoneRequestLoading() {
    emit(state.copyWith(phoneRequestStatus: RequestStatus.initial));
  }

  void resetOnLogout() => emit(const AdDetailsState());

  PaginationList<AdModel> _append(
    PaginationList<AdModel> current,
    PaginationList<AdModel> next,
  ) {
    return _copyPage(next, [...?current.data, ...?next.data]);
  }

  PaginationList<AdModel> _copyPage(
    PaginationList<AdModel> page,
    List<AdModel> data,
  ) {
    return PaginationList<AdModel>(
      data: data,
      currentPage: page.currentPage,
      firstPageUrl: page.firstPageUrl,
      from: page.from,
      lastPage: page.lastPage,
      lastPageUrl: page.lastPageUrl,
      nextPageUrl: page.nextPageUrl,
      path: page.path,
      perPage: page.perPage,
      prevPageUrl: page.prevPageUrl,
      to: page.to,
      total: page.total,
    );
  }
}
