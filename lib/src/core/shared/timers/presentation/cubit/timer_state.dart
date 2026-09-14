import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  const TimerState({
    this.remainingSeconds = 60,
    this.isResendButtonVisible = false,
  });

  final int remainingSeconds;
  final bool isResendButtonVisible;

  TimerState copyWith({int? remainingSeconds, bool? isResendButtonVisible}) =>
      TimerState(
        remainingSeconds: remainingSeconds ?? this.remainingSeconds,
        isResendButtonVisible:
            isResendButtonVisible ?? this.isResendButtonVisible,
      );

  @override
  List<Object?> get props => [remainingSeconds, isResendButtonVisible];
}
