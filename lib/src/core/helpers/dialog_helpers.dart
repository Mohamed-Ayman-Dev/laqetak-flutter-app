import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/widgets/dialog_content/confirm_dialog_content.dart';
import 'package:laqetak/src/core/widgets/dialog_content/report_dialog_content.dart';
import 'package:laqetak/src/core/widgets/dialog_content/terms_dialog_content.dart';
import 'package:laqetak/src/core/widgets/dialog_content/yes_no_dialog_content.dart';

import '../di/locator_service.dart';
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
      barrierColor: Colors.black.withOpacity(0.2),
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
      barrierColor: Colors.black.withOpacity(0.2),
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
      barrierColor: Colors.black.withOpacity(0.2),
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
  }) async {
    await showGeneralDialog(
      context: LocatorService.navigationService.currentState!.context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
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
              content: ReportDialogContent(
                id: id,
                isCustomerReport: isCustomerReport,
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
    );
  }

  //
  // static Future<void>? showOrderDeleteDialog(
  //   BuildContext context, {
  //   bool pop = false,
  //   required num id,
  // }) async {
  //   await showGeneralDialog(
  //     context: context,
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.2),
  //     transitionDuration: const Duration(milliseconds: 400),
  //     pageBuilder: (_, __, ___) {
  //       return Stack(
  //         children: [
  //           BackdropFilter(
  //             filter: ImageFilter.blur(
  //               sigmaX: 5,
  //               sigmaY: 5,
  //               tileMode: TileMode.decal,
  //             ),
  //             child: const SizedBox.expand(),
  //           ),
  //           AlertDialog(
  //             backgroundColor: Colors.white,
  //             elevation: 0,
  //             surfaceTintColor: Colors.transparent,
  //             contentPadding: EdgeInsets.zero,
  //             scrollable: true,
  //             insetPadding: const EdgeInsets.symmetric(
  //               horizontal: 0,
  //               vertical: 0,
  //             ).r,
  //             content: OrderDeleteContent(id: id),
  //           ),
  //         ],
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: const Offset(0, 1),
  //           end: Offset.zero,
  //         ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
  //         child: FadeTransition(opacity: anim, child: child),
  //       );
  //     },
  //   );
  // }
  //
  // static Future<void>? showDeleteItemDialog(
  //   BuildContext context, {
  //   required num itemId,
  //   required num requestId,
  // }) async {
  //   await showGeneralDialog(
  //     context: context,
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.2),
  //     transitionDuration: const Duration(milliseconds: 400),
  //     pageBuilder: (_, __, ___) {
  //       return Stack(
  //         children: [
  //           BackdropFilter(
  //             filter: ImageFilter.blur(
  //               sigmaX: 5,
  //               sigmaY: 5,
  //               tileMode: TileMode.decal,
  //             ),
  //             child: const SizedBox.expand(),
  //           ),
  //           AlertDialog(
  //             backgroundColor: Colors.white,
  //             elevation: 0,
  //             surfaceTintColor: Colors.transparent,
  //             contentPadding: EdgeInsets.zero,
  //             scrollable: true,
  //             insetPadding: const EdgeInsets.symmetric(
  //               horizontal: 0,
  //               vertical: 0,
  //             ).r,
  //             content: ItemDeleteContent(itemId: itemId, requestId: requestId),
  //           ),
  //         ],
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: const Offset(0, 1),
  //           end: Offset.zero,
  //         ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
  //         child: FadeTransition(opacity: anim, child: child),
  //       );
  //     },
  //   );
  // }
  //
  // static Future<bool?> showYesOrNoDialog({
  //   required String title,
  //   required String description,
  //   required String buttonText,
  //   required void Function()? onYes,
  //   Color? color,
  // }) async {
  //   final result = await showGeneralDialog(
  //     context: currentContext,
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.2),
  //     transitionDuration: const Duration(milliseconds: 400),
  //     pageBuilder: (_, __, ___) {
  //       return AlertDialog(
  //         backgroundColor: Colors.transparent,
  //         elevation: 0,
  //         surfaceTintColor: Colors.transparent,
  //         contentPadding: EdgeInsets.zero,
  //         scrollable: true,
  //         insetPadding: const EdgeInsets.symmetric(
  //           horizontal: 0,
  //           vertical: 0,
  //         ).r,
  //         content: YesNoAlert(
  //           title: title,
  //           description: description,
  //           yesText: buttonText,
  //           yesColor: color,
  //           onYes: onYes ?? () {},
  //         ),
  //       );
  //     },
  //     transitionBuilder: (_, anim, __, child) {
  //       return SlideTransition(
  //         position: Tween<Offset>(
  //           begin: const Offset(0, 1),
  //           end: Offset.zero,
  //         ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInOut)),
  //         child: FadeTransition(opacity: anim, child: child),
  //       );
  //     },
  //   );
  //   return (result as bool?) ?? false;
  // }

  static Future<void>? showTermsDialog({
    String? title,
    bool isIdea = false,
  }) async {
    await showGeneralDialog(
      context: currentContext,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
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
