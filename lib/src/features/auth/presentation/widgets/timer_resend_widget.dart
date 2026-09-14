import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/shared/timers/presentation/cubit/timer_cubit.dart';
import '../../../../core/shared/timers/presentation/cubit/timer_state.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class TimerResendWidget extends StatefulWidget {
  final String phone;
  final OtpFlow flow;
  final int? remainingSeconds;
  final Map<String, dynamic>? argsFormData;

  const TimerResendWidget({
    super.key,
    required this.phone,
    required this.flow,
    this.remainingSeconds,
    this.argsFormData,
  });

  @override
  State<TimerResendWidget> createState() => _TimerResendWidgetState();
}

class _TimerResendWidgetState extends State<TimerResendWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocatorService.timerCubit.startTimer(
        initialSeconds: widget.remainingSeconds ?? 60,
      );
    });
  }

  @override
  void dispose() {
    LocatorService.timerCubit.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, timerState) {
        final minutes = timerState.remainingSeconds ~/ 60;
        final seconds = timerState.remainingSeconds % 60;
        final timeString =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: S.of(context).didntReceiveTheCode,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.labelGreyTextColor,
              ),
              children: [
                TextSpan(text: '  '),
                TextSpan(
                  text: timerState.isResendButtonVisible
                      ? S.of(context).resendCode
                      : timeString,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: timerState.isResendButtonVisible
                        ? AppColors.primaryColor
                        : Colors.black,
                    fontWeight: timerState.isResendButtonVisible
                        ? null
                        : FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = timerState.isResendButtonVisible
                        ? () async {
                            if (widget.flow == OtpFlow.forgetPassword) {
                              await LocatorService.authCubit.forgetPassword({
                                'phone': widget.phone,
                              }, isRefresh: true);
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            } else if (widget.flow == OtpFlow.login) {
                              await LocatorService.authCubit.login(
                                widget.argsFormData ?? {},
                                isRefresh: true,
                              );
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            } else if (widget.flow == OtpFlow.register) {
                              await LocatorService.authCubit.registerOtpResend({
                                'phone': widget.phone,
                              });
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            } else if (widget.flow == OtpFlow.updatePhone) {
                              await LocatorService.authCubit.sendPhoneOtp(
                                widget.argsFormData ?? {},
                                isRefresh: true,
                              );
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            } else if (widget.flow == OtpFlow.addAd) {
                              await LocatorService.myAdsCubit.sendAdOtp(
                                widget.argsFormData ?? {},
                                isRefresh: true,
                              );
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            } else if (widget.flow == OtpFlow.editAd) {
                              await LocatorService.myAdsCubit.sendAdOtp(
                                widget.argsFormData ?? {},
                                edit: true,
                                isRefresh: true,
                              );
                              LocatorService.timerCubit.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                            }
                          }
                        : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
