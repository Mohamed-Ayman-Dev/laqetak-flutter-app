import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibration/vibration.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/themes/colors.dart';

class NotificationsService {
  bool permissionChecked = false;

  Future<void> initPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> askNotificationPermission() async {
    if (permissionChecked) return;
    permissionChecked = true; // Mark as checked

    final PermissionStatus currentStatus = await Permission.notification.status;
    if (currentStatus.isGranted) {
      return;
    }
    if (currentStatus.isDenied || currentStatus.isPermanentlyDenied) {
      final PermissionStatus newStatus = await Permission.notification
          .request();
      if (newStatus.isGranted) {
        initPermission();
      } else if (newStatus.isDenied) {
        EasyLoading.showToast(
          S.current.pleaseAllowNotificationsPermissionToGetUpdatesInSettings,
          dismissOnTap: true,
          toastPosition: EasyLoadingToastPosition.bottom,
          duration: const Duration(seconds: 3),
        );
      } else if (newStatus.isPermanentlyDenied) {
      }
    }
  }

  _handleReceivedNotification(RemoteMessage message) async {
    final data = message.data;
    String? type = data['item_type'];
    if (type != null && (type == 'new_quotation') ||
        type == 'quote_offer_updated' ||
        type == 'quote_request_updated') {
      if (isAuth) {
      }
    } else if (type != null && type == 'delivery_status_updated') {
      if (isAuth) {
      }
    }
    final context = LocatorService.navigationService.currentState!.context;
    if (message.notification != null) {
      FlutterRingtonePlayer().playNotification();
      if ((await Vibration.hasVibrator()) ?? false) {
        if ((await Vibration.hasAmplitudeControl()) ?? false) {
          Vibration.vibrate(duration: 500, amplitude: 128);
        } else {
          Vibration.vibrate(duration: 500);
        }
      }

      if (!context.mounted) return;
      Flushbar(
        icon: Container(
          width: 70.w,
          margin: const EdgeInsets.only(right: 10).r,
          height: 70.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.fitWidth,
            ),
            boxShadow: [
              BoxShadow(color: AppColors.cardShadowColor, blurRadius: 10),
            ],
          ),
        ),
        mainButton: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 14, color: AppColors.labelTextColor),
        ),
        title: message.notification?.title ?? '',
        message: message.notification?.body ?? '',
        messageColor: AppColors.bodyTextColor,
        titleColor: AppColors.titleTextColor,
        messageSize: 14.sp,
        dismissDirection: FlushbarDismissDirection.VERTICAL,
        isDismissible: true,
        boxShadows: [
          BoxShadow(
            color: AppColors.barrierColorLight,
            blurRadius: 5.0,
            spreadRadius: 5.0,
            offset: const Offset(0.0, 0.0),
          ),
        ],
        reverseAnimationCurve: Curves.easeIn,
        flushbarPosition: FlushbarPosition.TOP,
        forwardAnimationCurve: Curves.linear,
        backgroundColor: Colors.white.withOpacity(0.9),
        animationDuration: const Duration(milliseconds: 400),
        duration: const Duration(milliseconds: 3000),
        borderRadius: BorderRadius.circular(12),
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: (Flushbar ff) {
          notificationClicked(message);
        },
      ).show(context);
    }
  }

  notificationClicked(RemoteMessage message) async {
    final data = message.data;
    if (kDebugMode) {
      print(data);
    }
    String type = data['item_type'];

    if (type == 1) {
    } else if (type == 2) {
  }

  String? lastMessageId;

  Future<void> initializeFCM() async {
    final token = await LocatorService.authCubit.getDeviceToken();
    // ✅ Subscribe to topic
    await FirebaseMessaging.instance.subscribeToTopic('home_topic');
    print('✅ Subscribed to topic: home_topic');
    Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message,
    ) async {
      if (kDebugMode) {
        print(message);
      }
    }

    if (isAuth) {
      if (token != null) {
        LocatorService.authCubit.sendDeviceToken(token);
      }
    }
    initPermission();
    askNotificationPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.messageId != null && message.messageId == lastMessageId) {
        return;
      }
      lastMessageId = message.messageId;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      _handleReceivedNotification(message);
      print(message);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.messageId != null && message.messageId == lastMessageId) {
        return;
      }
      lastMessageId = message.messageId;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      notificationClicked(message);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
