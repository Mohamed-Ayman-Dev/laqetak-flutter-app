import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/shared/providers/timers.dart';
import '../../../../core/shared/widgets/buttons_widgets/custom_elevated_button.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/themes/text_styles.dart';

class TimerResendWidget extends StatefulWidget {
  final String phone;
  final String previousScreenName;
  final int? remainingSeconds;

  const TimerResendWidget({
    super.key,
    required this.phone,
    required this.previousScreenName,
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

        // Always show button with dynamic text
        return CustomElevatedButton(
          text: timers.isResendButtonVisible
              ? S.of(context).resend
              : '${S.of(context).resend} $timeString',
          backgroundColor: AppColors.primaryColor,
          textStyle: AppTextStyles.labelSmall.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textButtonTextColor,
          ),
          size: Size(150.w, 36.h),
          icon: 'assets/images/refresh.svg',
          onPressed: timers.isResendButtonVisible
              ? () async {
                  // if (widget.previousScreenName == 'forgetPassword') {
                  //   // Resend forget password OTP
                  //   await AuthController.forgetPassword(context, {
                  //     'phone': widget.phone,
                  //   }, isRefresh: true);
                  //   // Note: forgetPassword now handles navigation, just restart timer
                  //   timerProvider.startTimer(
                  //     initialSeconds: widget.remainingSeconds ?? 120,
                  //   );
                  // } else {
                  //   // Resend registration OTP
                  //   final response = await AuthController.registerOtpResend({
                  //     'phone': widget.phone,
                  //   });
                  //
                  //   if (response != null && response['status'] == true) {
                  //     // Restart the timer with remaining seconds from response
                  //     final remainingSeconds =
                  //         response['data']?['remainingSeconds'] ?? 120;
                  //     timerProvider.startTimer(
                  //       initialSeconds: remainingSeconds,
                  //     );
                  //   }
                  // }
                }
              : null,
        );
      },
    );
  }
}
