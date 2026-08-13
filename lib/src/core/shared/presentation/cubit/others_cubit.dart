import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';
import 'package:invastro/src/core/shared/data/repositories/others_repository.dart';

import 'others_state.dart';

class OthersCubit extends BaseCubit<OthersState> {
  final OthersRepository _othersRepository;

  OthersCubit(this._othersRepository) : super(const OthersState());

  // Future<void> getGeneralSettings() async {
  //   final result = await _othersRepository.getGeneralSettings();
  //   result.when(
  //     success: (settings) {
  //       emit(state.copyWith(mySettings: settings));
  //     },
  //     failure: (error) {
  //       AppFeedback.errorMessage(error);
  //     },
  //   );
  // }
}
