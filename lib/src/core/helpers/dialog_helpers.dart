import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/widgets/dialog_content/confirm_dialog_content.dart';
import 'package:laqetak/src/core/widgets/dialog_content/terms_dialog_content.dart';
import 'package:laqetak/src/core/widgets/dialog_content/yes_no_dialog_content.dart';

import '../../../../generated/l10n.dart';
import '../di/locator_service.dart';
import '../themes/colors.dart';
import '../themes/text_styles.dart';
import '../widgets/dialog_content/success_dialog_content.dart';

class DialogHelpers {
  static BuildContext currentContext =
      LocatorService.navigationService.currentState!.context;

  static Future<void>? showSuccessDialog({
    required String title,
    String? subtitle,
    String? buttonText,
    void Function()? onButtonTap,
    bool pop = false,
  }) async {
    await showGeneralDialog(
      context: LocatorService.navigationService.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: AppColors.barrierColor,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
                tileMode: TileMode.decal,
              ),
              child: const SizedBox.expand(),
            ),
            AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ).r,
              content: SuccessDialogContent(
                title: title,
                subtitle: subtitle,
                buttonText: buttonText,
                onButtonTap: onButtonTap,
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    ).then((value) {
      if (pop) {
        LocatorService.navigationService.currentState?.pop();
      }
    });
  }

  static Future<bool>? showConfirmDialog({
    required BuildContext context,
    required String title,
    required String description,
    required String buttonText,
    required void Function()? onYes,
    Color? color,
  }) async {
    final result = await showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: AppColors.barrierColor,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          scrollable: true,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ).r,
          content: ConfirmDialogContent(
            title: title,
            description: description,
            yesText: buttonText,
            yesColor: color,
            onYes: onYes ?? () {},
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
    return (result as bool?) ?? false;
  }

  static Future<void>? showYesNoDialog({
    required String title,
    String? subtitle,
    String? buttonText,
    void Function()? onButtonTap,
    bool pop = false,
  }) async {
    await showGeneralDialog(
      context: LocatorService.navigationService.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: AppColors.barrierColor,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
                tileMode: TileMode.decal,
              ),
              child: const SizedBox.expand(),
            ),
            AlertDialog(
              backgroundColor: Colors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ).r,
              content: YesNoDialogContent(
                title: title,
                buttonText: buttonText,
                subtitle: subtitle,
                onButtonTap: onButtonTap,
              ),
            ),
          ],
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    ).then((value) {
      if (pop) {
        LocatorService.navigationService.currentState?.pop();
      }
    });
  }

  static Future<void>? showReportDialog(
    num id, {
    bool isCustomerReport = false,
  }) {
    return showDemoDialog(
      message: S.current.demoReportMessage,
    );
  }

  static Future<void>? showDemoDialog({
    String? title,
    String? message,
  }) async {
    final context = LocatorService.navigationService.currentState!.context;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        icon: Icon(
          Icons.info_outline_rounded,
          size: 48.sp,
          color: AppColors.secondaryColor,
        ),
        title: Text(
          title ?? S.of(context).demoModeTitle,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.primaryColor,
            fontSize: 18.sp,
          ),
        ),
        content: Text(
          message ?? S.of(context).demoPaymentMessage,
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.bodyGreyTextColor,
            fontSize: 14.sp,
            height: 1.6,
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                S.of(context).understood,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void>? showTermsDialog({
    String? title,
    bool isIdea = false,
  }) async {
    await showGeneralDialog(
      context: currentContext,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: AppColors.barrierColor,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 0,
          ).r,
          content: TermsDialogContent(isIdea: isIdea, title: title),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }
}
