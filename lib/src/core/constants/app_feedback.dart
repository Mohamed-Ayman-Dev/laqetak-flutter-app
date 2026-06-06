import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:invastro/src/core/constants/constant.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';

import '../../../generated/l10n.dart';
import '../di/locator_service.dart';
import '../themes/colors.dart';

final class AppFeedback {
  AppFeedback._();

  static BuildContext get _ctx =>
      LocatorService.navigationService.currentState!.overlay!.context;

  static void successToast(String message) {
    EasyLoading.dismiss();
    _AppToast.show(_ctx, message: message, isError: false);
  }

  // static void successPopUp(String message, {String? desc}) {
  //   EasyLoading.dismiss();
  //   AlertUtils.showSuccessDialog(
  //     title: message,
  //     oneButton: true,
  //     pop: false,
  //     desc: desc,
  //     onTab: () {
  //       LocatorService.navigationService.currentState?.pop();
  //     },
  //   );
  // }

  static void loadingMessage({String? message}) {
    EasyLoading.show(status: message ?? S.current.pleaseWait);
  }

  static void errorMessage(dynamic message) {
    final errorMessage = message?.toString() ?? S.current.somethingWentWrong;
    EasyLoading.showError(
      errorMessage,
      dismissOnTap: true,
      duration: const Duration(seconds: 3),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCube
    ..loadingStyle = EasyLoadingStyle.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..indicatorColor = Colors.white
    ..backgroundColor = AppColors.appFeedbackBKColor
    ..textColor = AppColors.primaryColor
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..indicatorSize = 40.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: Constant.fontFamily,
    )
    // ..progressColor = Colors.yellow
    // ..backgroundColor = Colors.green
    ..indicatorWidget = SizedBox(
      width: 40,
      height: 40,
      child: SpinKitDoubleBounce(color: Colors.white),
    )
    // ..indicatorColor = Colors.yellow
    // ..textColor = Colors.yellow
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class _AppToast {
  _AppToast._();

  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show(
    BuildContext context, {
    required String message,
    required bool isError,
    Duration duration = const Duration(seconds: 3),
  }) {
    _dismiss();
    final overlay = Overlay.of(context, rootOverlay: true);
    _entry = OverlayEntry(
      builder: (_) => _ToastWidget(message: message, isError: isError),
    );
    overlay.insert(_entry!);
    _timer = Timer(duration, _dismiss);
  }

  static void _dismiss() {
    _timer?.cancel();
    _timer = null;
    _entry?.remove();
    _entry = null;
  }
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({required this.message, required this.isError});

  final String message;
  final bool isError;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isError = widget.isError;
    final bgColor = isError ? const Color(0xFFB00020) : AppColors.primaryColor;
    final icon = isError
        ? Icons.error_outline_rounded
        : Icons.check_circle_outline_rounded;

    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 28,
      left: 16,
      right: 16,
      child: Material(
        type: MaterialType.transparency,
        child: SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _opacity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon(icon, color: Colors.white, size: 22),
                  !isError
                      ? SvgPicture.asset(
                          SvgAssets.assetsSvgSuccessIcon,
                          width: 20.w,
                          height: 20.h,
                          color: Colors.white,
                        )
                      : Icon(icon, color: Colors.white, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        fontFamily: Constant.fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
