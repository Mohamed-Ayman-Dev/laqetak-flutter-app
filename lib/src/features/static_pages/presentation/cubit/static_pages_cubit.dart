import 'package:laqetak/src/core/bloc_helpers/base_cubit.dart';
import 'package:laqetak/src/features/static_pages/data/repositories/static_pages_repository.dart';

import '../../../../core/constants/enums.dart';
import 'static_pages_state.dart';

class StaticPagesCubit extends BaseCubit<StaticPagesState> {
  StaticPagesCubit(this._staticPagesRepository)
    : super(const StaticPagesState());

  final StaticPagesRepository _staticPagesRepository;

  Future<void> getFaqs() async {
    if (state.faqsStatus == RequestStatus.loading) return;
    emit(state.copyWith(faqsStatus: RequestStatus.loading));

    final result = await _staticPagesRepository.getFaqs();
    result.when(
      success: (faqs) => emit(
        state.copyWith(
          faqs: faqs ?? const [],
          faqsStatus: RequestStatus.success,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          faqsStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }

  Future<void> sendContactUs(Map<String, dynamic> data) async {
    if (state.contactStatus == RequestStatus.loading) return;
    emit(state.copyWith(contactStatus: RequestStatus.loading));

    final result = await _staticPagesRepository.sendContactUs(data);
    result.when(
      success: (_) =>
          emit(state.copyWith(contactStatus: RequestStatus.success)),
      failure: (error) => emit(
        state.copyWith(
          contactStatus: RequestStatus.error,
          errorMessage: error.message,
        ),
      ),
    );
  }
}
