import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/providers/timers.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class TimerResendWidget extends StatefulWidget {
  final String phone;
  final OtpFlow flow;
  final int? remainingSeconds;

  const TimerResendWidget({
    super.key,
    required this.phone,
    required this.flow,
    this.remainingSeconds,
  });

  @override
  State<TimerResendWidget> createState() => _TimerResendWidgetState();
}

class _TimerResendWidgetState extends State<TimerResendWidget> {
  bool once = false;
  late Timers timerProvider;

  @override
  void didChangeDependencies() {
    if (!once) {
      timerProvider = Provider.of<Timers>(context, listen: true);
      // Start the timer with the initial seconds from the backend if available
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        timerProvider.startTimer(initialSeconds: widget.remainingSeconds ?? 60);
      });
      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Stop the timer when the widget is disposed to avoid memory leaks
    timerProvider.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Timers>(
      builder: (context, timers, child) {
        // Calculate minutes and seconds for display
        final minutes = timers.timer ~/ 60;
        final seconds = timers.timer % 60;
        final timeString =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        return Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "لم تستلم الرمز ؟",
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.labelGreyTextColor,
              ),
              children: [
                TextSpan(text: '  '),
                TextSpan(
                  text: timers.isResendButtonVisible
                      ? "أعد إرسال الرمز"
                      : timeString,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: timers.isResendButtonVisible
                        ? AppColors.primaryColor
                        : Colors.black,
                    fontWeight: timers.isResendButtonVisible
                        ? null
                        : FontWeight.w700,
                    fontSize: 14.sp,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      timers.isResendButtonVisible
                          ? () async {
                              // if (widget.previousScreenName == 'forgetPassword') {
                              //   // Resend forget password OTP
                              //   await AuthController.forgetPassword(context, {
                              //     'phone': widget.phone,
                              //   }, isRefresh: true);
                              //   // Note: forgetPassword now handles navigation, just restart timer
                              timerProvider.startTimer(
                                initialSeconds: widget.remainingSeconds ?? 120,
                              );
                              // } else {
                              //   // Resend registration OTP
                              //   final response = await AuthController.registerOtpResend({
                              //     'phone': widget.phone,
                              //   });
                              //
                              //   if (response != null && response['status'] == true) {
                              //     // Restart the timer with remaining seconds from response
                              final remainingSeconds = 120;
                              //         response['data']?['remainingSeconds'] ?? 120;
                              timerProvider.startTimer(
                                initialSeconds: remainingSeconds,
                              );
                              //   }
                              // }
                            }
                          : null;
                    },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
