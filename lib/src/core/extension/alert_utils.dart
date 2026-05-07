import 'package:flutter/material.dart';

import '../di/locator_service.dart';

class AlertUtils {
  static BuildContext currentContext =
      LocatorService.navigationService.currentState!.context;
  //
  // static Future<bool> showPassDialog(
  //   BuildContext context,
  //   GlobalKey<FormState> formKey,
  // ) async {
  //   String? reason;
  //   final result = await showGeneralDialog<bool>(
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
  //             backgroundColor: Colors.transparent,
  //             elevation: 0,
  //             surfaceTintColor: Colors.transparent,
  //             contentPadding: EdgeInsets.zero,
  //             scrollable: true,
  //             insetPadding: const EdgeInsets.symmetric(
  //               horizontal: 0,
  //               vertical: 0,
  //             ).r,
  //             content: PassDialog(),
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
  //
  //   return result ?? false; // Ensure a boolean is always returned
  // }
  //
  // static void changeLanguage(
  //   context,
  //   String languageCode, {
  //   bool showSplashScreen = true,
  // }) {
  //   if (Intl.getCurrentLocale() != languageCode) {
  //     if (showSplashScreen) {
  //       Navigator.of(context)
  //           .push(
  //             NavigationHelper.slideRightRouteBuilder(
  //               context,
  //               const TimeoutSplashScreen(),
  //               const Duration(milliseconds: 600),
  //               {'timeout': const Duration(seconds: 1)},
  //               TimeoutSplashScreen.routeName,
  //             ),
  //           )
  //           .then((_) async {
  //             await LocatorService.appSettings.changeLanguage(languageCode);
  //             LocatorService.navigationService.currentState!
  //                 .pushNamedAndRemoveUntil(
  //                   HomeLayoutScreen.routeName,
  //                   (route) => false,
  //                 );
  //             if (isAuth) {
  //               StoresController.getFamousStores(refresh: true);
  //               //  ProductsController.getBestSellingProducts();
  //               //  StoresController.getFamousStores();
  //               // AuthController.getProfile();
  //             }
  //           });
  //     } else {
  //       LocatorService.appSettings.changeLanguage(languageCode);
  //     }
  //   }
  // }
  //
  // static Future<void>? showSuccessDialog({
  //   bool pop = false,
  //   String? title,
  //   String? desc,
  //   void Function()? onTab,
  //   bool oneButton = false,
  // }) async {
  //   await showGeneralDialog(
  //     context: LocatorService.navigationService.currentState!.context,
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
  //             content: OrderSuccessContent(
  //               title: title,
  //               oneButton: oneButton,
  //               desc: desc,
  //               onTab: onTab,
  //             ),
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
  //   ).then((value) {
  //     if (pop) {
  //       LocatorService.navigationService.currentState?.pop();
  //     }
  //   });
  // }
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
  //
  // static Future<void>? showGhiarYesOrNoDialog({
  //   String? title,
  //   String? description,
  //   String? buttonText,
  //   void Function()? onYes,
  // }) async {
  //   await showGeneralDialog(
  //     context: currentContext,
  //     barrierLabel: "Barrier",
  //     barrierDismissible: true,
  //     barrierColor: Colors.black.withOpacity(0.2),
  //     transitionDuration: const Duration(milliseconds: 400),
  //     pageBuilder: (_, __, ___) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         elevation: 0,
  //         surfaceTintColor: Colors.transparent,
  //         contentPadding: EdgeInsets.zero,
  //         scrollable: true,
  //         insetPadding: const EdgeInsets.symmetric(
  //           horizontal: 20,
  //           vertical: 0,
  //         ).r,
  //         content: GhiarYesNoAlert(
  //           title: title,
  //           description: description,
  //           buttonText: buttonText,
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
  // }
  //
}
