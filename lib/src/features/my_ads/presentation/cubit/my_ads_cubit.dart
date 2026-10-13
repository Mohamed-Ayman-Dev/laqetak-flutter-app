import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/my_ads/data/repositories/my_ads_repository.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/pagination_list.dart';
import '../../../../core/shared/models/ad_model.dart';
import 'my_ads_state.dart';

class MyAdsCubit extends BaseCubit<MyAdsState> {
  MyAdsCubit(this._myAdsRepository) : super(const MyAdsState());

  final MyAdsRepository _myAdsRepository;

  Future<void> getMyAds({bool refresh = false}) async {
    final current = state.ads;
    if (!refresh &&
        current != null &&
        current.currentPage != null &&
        current.currentPage == current.lastPage) {
      return;
    }
    if (state.listStatus == RequestStatus.loading) return;

    emit(state.copyWith(listStatus: RequestStatus.loading));
    final nextPage = refresh ? 1 : ((current?.currentPage ?? 0) + 1);
    final result = await _myAdsRepository.getMyAds(nextPage);
    result.when(
      success: (page) => emit(
        state.copyWith(
          ads: refresh || current == null ? page : _append(current, page),
          listStatus: RequestStatus.success,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          listStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> addAd(Map<String, dynamic>? data) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.add,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.addAd(_prepareAdData(data));
    result.when(
      success: (ad) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: MyAdsMutation.add,
          createdAd: ad,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: MyAdsMutation.add,
          verificationErrorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> editAd(
    Map<String, dynamic>? data, {
    bool checkOtp = true,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.edit,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.editAd(_prepareAdData(data));
    result.when(
      success: (_) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: MyAdsMutation.edit,
        ),
      ),
      failure: (error) => emit(
        checkOtp
            ? state.copyWith(
                actionStatus: RequestStatus.error,
                lastMutation: MyAdsMutation.edit,
                verificationErrorMessage: error.message,
              )
            : state.copyWith(
                actionStatus: RequestStatus.error,
                lastMutation: MyAdsMutation.edit,
                errorMessage: error.message,
              ),
      ),
    );
  }

  Future<void> sendAdOtp(
    Map<String, dynamic>? data, {
    bool edit = false,
    bool isRefresh = false,
  }) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.otp,
        otpResent: isRefresh,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.sendAdOtp({
      'contact_phone': data?['contact_phone'],
    });
    result.when(
      success: (otp) {
        final redirect = otp.redirect;
        if (redirect != null) {
          redirect.phone = data?['contact_phone'];
        }
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: MyAdsMutation.otp,
            otpRedirect: redirect,
            otpMessage: otp.message,
            otpFormData: data,
            otpIsEdit: edit,
            otpResent: isRefresh,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: MyAdsMutation.otp,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> deleteAd(num id) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.delete,
        lastAdId: id,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.deleteAd(id);
    await result.when(
      success: (_) async {
        await getMyAds(refresh: true);
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: MyAdsMutation.delete,
          ),
        );
      },
      failure: (error) async => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: MyAdsMutation.delete,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> payAd(Map<String, dynamic> data) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.pay,
        clearCheckout: true,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.payAd(data);
    result.when(
      success: (pay) => emit(
        state.copyWith(
          actionStatus: RequestStatus.success,
          lastMutation: MyAdsMutation.pay,
          checkoutUrl: pay.checkoutUrl,
          paymentTime: pay.time,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: MyAdsMutation.pay,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> closeAd(num id) async {
    if (state.actionStatus == RequestStatus.loading) return;
    emit(
      state.copyWith(
        actionStatus: RequestStatus.loading,
        lastMutation: MyAdsMutation.close,
        lastAdId: id,
        clearVerification: true,
      ),
    );
    final result = await _myAdsRepository.closeAd(id);
    result.when(
      success: (_) {
        getMyAds(refresh: true);
        emit(
          state.copyWith(
            actionStatus: RequestStatus.success,
            lastMutation: MyAdsMutation.close,
          ),
        );
      },
      failure: (error) => emit(
        state.copyWith(
          actionStatus: RequestStatus.error,
          lastMutation: MyAdsMutation.close,
          errorMessage: error.message,
        ),
      ),
    );
  }

  void resetOnLogout() {
    emit(
      const MyAdsState(
        listStatus: RequestStatus.initial,
        actionStatus: RequestStatus.initial,
      ),
    );
  }

  Map<String, dynamic> _prepareAdData(Map<String, dynamic>? data) {
    final ready = Map<String, dynamic>.from(data ?? {});
    if (ready['photos[]'] != null && ready['photos[]'].isNotEmpty) {
      final files = <MultipartFile>[];
      for (final path in ready['photos[]']) {
        if (path is MultipartFile) {
          files.add(path);
          continue;
        }
        if (path is XFile) {
          files.add(MultipartFile.fromFileSync(path.path, filename: path.name));
        }
      }
      if (files.isNotEmpty) {
        ready['photos[]'] = files;
      }
    }
    return ready;
  }

  PaginationList<AdModel> _append(
    PaginationList<AdModel> current,
    PaginationList<AdModel> next,
  ) {
    return PaginationList<AdModel>(
      data: [...?current.data, ...?next.data],
      currentPage: next.currentPage,
      firstPageUrl: next.firstPageUrl,
      from: next.from,
      lastPage: next.lastPage,
      lastPageUrl: next.lastPageUrl,
      nextPageUrl: next.nextPageUrl,
      path: next.path,
      perPage: next.perPage,
      prevPageUrl: next.prevPageUrl,
      to: next.to,
      total: next.total,
    );
  }
}
