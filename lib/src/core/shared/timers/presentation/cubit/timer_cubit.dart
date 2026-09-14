import 'dart:async';

import 'package:invastro/src/core/bloc_helpers/base_cubit.dart';

import 'timer_state.dart';

class TimerCubit extends BaseCubit<TimerState> {
  TimerCubit() : super(const TimerState());

  Timer? _ticker;

  void startTimer({num? initialSeconds}) {
    _ticker?.cancel();
    emit(
      TimerState(
        remainingSeconds: (initialSeconds ?? 60).toInt(),
        isResendButtonVisible: false,
      ),
    );
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds == 0) {
        emit(state.copyWith(isResendButtonVisible: true));
        stopTimer();
      } else {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      }
    });
  }

  void stopTimer() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  Future<void> close() {
    stopTimer();
    return super.close();
  }
}
