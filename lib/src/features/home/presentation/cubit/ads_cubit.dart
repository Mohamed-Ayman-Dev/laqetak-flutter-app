import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/home/data/repositories/ads_repository.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_feedback.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/helpers/dialog_helpers.dart';
import '../../../../core/shared/models/ad_model.dart';
import '../../../../core/shared/models/pagination_list.dart';
import 'ads_state.dart';

class AdsCubit extends BaseCubit<AdsState> {
  AdsCubit(this._adsRepository) : super(const AdsState());

  final AdsRepository _adsRepository;

  Future<void> getAds({
    bool refresh = false,
    bool showLoadingSearch = false,
    Map<String, dynamic>? filters,
    num? typeId,
    String? search,
  }) async {
    final current = state.ads;
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.adsStatus == RequestStatus.loading) return;

    emit(
      state.copyWith(
        adsStatus: RequestStatus.loading,
        loadingSearch: showLoadingSearch ? true : state.loadingSearch,
        filters: filters ?? state.filters,
      ),
    );
    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _adsRepository.getAds(
      page: nextPage,
      typeId: typeId,
      search: search,
      filters: filters ?? state.filters,
    );
    result.when(
      success: (page) => emit(
        state.copyWith(
          ads: refresh || current == null ? page : _append(current, page),
          adsStatus: RequestStatus.success,
          loadingSearch: false,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          adsStatus: RequestStatus.error,
          loadingSearch: false,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> getFavAds({bool refresh = false}) async {
    final current = state.favAds;
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.favAdsStatus == RequestStatus.loading) return;

    emit(state.copyWith(favAdsStatus: RequestStatus.loading));
    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _adsRepository.getFavAds(nextPage);
    result.when(
      success: (page) => emit(
        state.copyWith(
          favAds: refresh || current == null ? page : _append(current, page),
          favAdsStatus: RequestStatus.success,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          favAdsStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> toggleFavorite(AdModel ad) async {
    final id = ad.id;
    if (id == null) return;
    final newState = !(ad.isFavorite ?? false);
    emit(
      _withFavorite(
        state,
        id,
        newState,
        favoriteTitle: ad.title,
        favoriteAdded: newState,
      ),
    );
    AppFeedback.showToast(
      "${ad.title ?? ''} ${newState ? S.current.added : S.current.removed} ${newState ? S.current.toFavoritesSuccessfully : S.current.fromFavoritesSuccessfully}",
    );
    final result = await _adsRepository.toggleFav(id);
    result.when(
      success: (_) {},
      failure: (error) {
        emit(state.copyWith(errorMessage: error.message));
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  Future<void> getAdDetails(num adId) async {
    emit(state.copyWith(adDetailsStatus: RequestStatus.loading));
    final result = await _adsRepository.getAdDetails(adId);
    result.when(
      success: (ad) {
        final details = Map<num, AdModel>.from(state.adDetails);
        details[adId] = ad;
        emit(
          state.copyWith(
            adDetails: details,
            adDetailsStatus: RequestStatus.success,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          adDetailsStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> sendAdComplaint(Map<String, dynamic> data) async {
    if (state.complaintStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        complaintStatus: RequestStatus.loading,
        complaintTarget: ComplaintTarget.ad,
      ),
    );
    AppFeedback.loadingMessage();
    final result = await _adsRepository.sendAdComplaint(data);
    result.when(
      success: (_) {
        emit(state.copyWith(complaintStatus: RequestStatus.success));
        EasyLoading.dismiss();
        DialogHelpers.showSuccessDialog(
          title: S.current.reportSubmittedSuccessfully,
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            complaintStatus: RequestStatus.error,
            errorMessage: error.message,
          ),
        );
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  Future<void> sendCustomerComplaint(Map<String, dynamic> data) async {
    if (state.complaintStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        complaintStatus: RequestStatus.loading,
        complaintTarget: ComplaintTarget.customer,
      ),
    );
    AppFeedback.loadingMessage();
    final result = await _adsRepository.sendCustomerComplaint(data);
    result.when(
      success: (_) {
        emit(state.copyWith(complaintStatus: RequestStatus.success));
        EasyLoading.dismiss();
        DialogHelpers.showSuccessDialog(
          title: S.current.reportSentSuccessfully,
        );
      },
      failure: (error) {
        emit(
          state.copyWith(
            complaintStatus: RequestStatus.error,
            errorMessage: error.message,
          ),
        );
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  void setFilters(Map<String, dynamic> data) {
    emit(state.copyWith(filters: Map<String, dynamic>.from(data)));
  }

  void setHidePhone(num id, {required num hide}) {
    final details = Map<num, AdModel>.from(state.adDetails);
    final current = details[id];
    if (current == null) return;
    details[id] = current.copyWith(hidePhone: hide);
    emit(state.copyWith(adDetails: details));
  }

  void resetOnLogout() {
    emit(
      state.copyWith(
        clearFavAds: true,
        filters: const {},
        favAdsStatus: RequestStatus.initial,
        loadingSearch: false,
      ),
    );
  }

  AdsState _withFavorite(
    AdsState current,
    num id,
    bool isFavorite, {
    String? favoriteTitle,
    bool? favoriteAdded,
  }) {
    PaginationList<AdModel>? updatePage(
      PaginationList<AdModel>? page, {
      bool removeIfUnfav = false,
    }) {
      if (page?.data == null) return page;
      var data = page!.data!
          .map((ad) => ad.id == id ? ad.copyWith(isFavorite: isFavorite) : ad)
          .toList();
      if (removeIfUnfav && !isFavorite) {
        data = data.where((ad) => ad.id != id).toList();
      }
      return _copyPage(page, data);
    }

    final details = Map<num, AdModel>.from(current.adDetails);
    final detail = details[id];
    if (detail != null) {
      details[id] = detail.copyWith(isFavorite: isFavorite);
    }

    return current.copyWith(
      ads: updatePage(current.ads),
      favAds: updatePage(current.favAds, removeIfUnfav: true),
      adDetails: details,
      favoriteEventId: current.favoriteEventId + 1,
      favoriteTitle: favoriteTitle,
      favoriteAdded: favoriteAdded,
    );
  }

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
