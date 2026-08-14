import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/shared/data/repositories/others_repository.dart';

import '../../../constants/app_feedback.dart';
import 'others_state.dart';

class OthersCubit extends BaseCubit<OthersState> {
  final OthersRepository _othersRepository;

  OthersCubit(this._othersRepository) : super(OthersState());

  Future<void> getCategories() async {
    final result = await _othersRepository.getCategories();
    result.when(
      success: (categories) {},
      failure: (error) {
        AppFeedback.errorMessage(error);
      },
    );
  }
}
