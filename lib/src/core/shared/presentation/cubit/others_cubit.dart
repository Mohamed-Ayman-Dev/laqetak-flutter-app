import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/shared/data/repositories/others_repository.dart';

import '../../../constants/app_feedback.dart';
import '../../../constants/enums.dart';
import 'others_state.dart';

/// Holds the lookup lists shared between screens (categories, cities, sectors
/// and budget ranges). Every call refetches so the UI always reflects the latest
/// backend data; the old list stays visible while the new one is loading.
class OthersCubit extends BaseCubit<OthersState> {
  OthersCubit(this._othersRepository) : super(const OthersState());

  final OthersRepository _othersRepository;

  Future<void> getCategories() async {
    if (state.categoriesStatus == RequestStatus.loading) return;
    emit(state.copyWith(categoriesStatus: RequestStatus.loading));

    final result = await _othersRepository.getCategories();
    result.when(
      success: (categories) => emit(
        state.copyWith(
          categories: categories ?? const [],
          categoriesStatus: RequestStatus.success,
        ),
      ),
      failure: (error) {
        emit(state.copyWith(categoriesStatus: RequestStatus.error));
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  Future<void> getCities() async {
    if (state.citiesStatus == RequestStatus.loading) return;
    emit(state.copyWith(citiesStatus: RequestStatus.loading));

    final result = await _othersRepository.getCities();
    result.when(
      success: (cities) => emit(
        state.copyWith(
          cities: cities ?? const [],
          citiesStatus: RequestStatus.success,
        ),
      ),
      failure: (error) {
        emit(state.copyWith(citiesStatus: RequestStatus.error));
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  Future<void> getSectors() async {
    if (state.sectorsStatus == RequestStatus.loading) return;
    emit(state.copyWith(sectorsStatus: RequestStatus.loading));

    final result = await _othersRepository.getSectors();
    result.when(
      success: (sectors) => emit(
        state.copyWith(
          sectors: sectors ?? const [],
          sectorsStatus: RequestStatus.success,
        ),
      ),
      failure: (error) {
        emit(state.copyWith(sectorsStatus: RequestStatus.error));
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  Future<void> getBudgetRanges() async {
    if (state.budgetRangesStatus == RequestStatus.loading) return;
    emit(state.copyWith(budgetRangesStatus: RequestStatus.loading));

    final result = await _othersRepository.getBudgetRanges();
    result.when(
      success: (budgetRanges) => emit(
        state.copyWith(
          budgetRanges: budgetRanges ?? const [],
          budgetRangesStatus: RequestStatus.success,
        ),
      ),
      failure: (error) {
        emit(state.copyWith(budgetRangesStatus: RequestStatus.error));
        AppFeedback.errorMessage(error.message);
      },
    );
  }

  /// Loads every list in parallel, for screens that need them all.
  Future<void> loadAll() async {
    await Future.wait([
      getCategories(),
      getCities(),
      getSectors(),
      getBudgetRanges(),
    ]);
  }

  void clear() => emit(const OthersState());
}
