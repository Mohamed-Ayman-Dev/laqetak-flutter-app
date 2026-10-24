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
  bool _permissionChecked = false;
  String? _lastMessageId;

  // ─── Public API ────────────────────────────────────────────────

  /// Bootstraps FCM: registers the device token, requests permission,
  /// subscribes to topics, and starts listening for messages.
  Future<void> initializeFCM() async {
    await _registerDeviceToken();
    await _setupPermissions();
    _subscribeTopic('home_topic');
    _listenForegroundMessages();
    _listenMessageOpenedApp();
  }

  // ─── Setup Helpers ─────────────────────────────────────────────

  Future<void> _registerDeviceToken() async {
    if (!isAuth) return;
    final token = await LocatorService.authCubit.getDeviceToken();
    if (token != null) {
      LocatorService.authCubit.sendDeviceToken(token);
    }
  }

  Future<void> _setupPermissions() async {
    await _initApnsPermission();
    await _askNotificationPermission();
  }

  Future<void> _initApnsPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _askNotificationPermission() async {
    if (_permissionChecked) return;
    _permissionChecked = true;

    final status = await Permission.notification.status;
    if (status.isGranted) return;

    final newStatus = await Permission.notification.request();
    if (newStatus.isGranted) {
      await _initApnsPermission();
    } else if (newStatus.isDenied) {
      EasyLoading.showToast(
        S.current.pleaseAllowNotificationsPermissionToGetUpdatesInSettings,
        dismissOnTap: true,
        toastPosition: EasyLoadingToastPosition.bottom,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _subscribeTopic(String topic) {
    FirebaseMessaging.instance.subscribeToTopic(topic);
    if (kDebugMode) print('✅ Subscribed to topic: $topic');
  }

  // ─── Listeners ─────────────────────────────────────────────────

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (_isDuplicate(message)) return;
      if (kDebugMode) print('FCM foreground: ${message.data}');
      _showInAppBanner(message);
    });
  }

  void _listenMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (_isDuplicate(message)) return;
      if (kDebugMode) print('FCM opened app: ${message.data}');
      _onNotificationTapped(message);
    });
  }

  bool _isDuplicate(RemoteMessage message) {
    if (message.messageId != null && message.messageId == _lastMessageId) {
      return true;
    }
    _lastMessageId = message.messageId;
    return false;
  }

  // ─── Notification Tap Handler ──────────────────────────────────

  void _onNotificationTapped(RemoteMessage message) {
    if (kDebugMode) print('Notification tapped: ${message.data}');
  }

  // ─── In-App Banner ────────────────────────────────────────────

  Future<void> _showInAppBanner(RemoteMessage message) async {
    if (message.notification == null) return;

    await _playAlertFeedback();

    final context = LocatorService.navigationService.currentState?.context;
    if (context == null || !context.mounted) return;

    Flushbar(
      icon: _buildBannerIcon(),
      mainButton: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.close,
          size: 14,
          color: AppColors.labelTextColor,
        ),
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
        ),
      ],
      reverseAnimationCurve: Curves.easeIn,
      flushbarPosition: FlushbarPosition.TOP,
      forwardAnimationCurve: Curves.linear,
      backgroundColor: Colors.white.withOpacity(0.9),
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 3000),
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      onTap: (_) => _onNotificationTapped(message),
    ).show(context);
  }

  Future<void> _playAlertFeedback() async {
    FlutterRingtonePlayer().playNotification();
    final hasVibrator = (await Vibration.hasVibrator()) ?? false;
    if (!hasVibrator) return;
    final hasAmplitude = (await Vibration.hasAmplitudeControl()) ?? false;
    Vibration.vibrate(duration: 500, amplitude: hasAmplitude ? 128 : -1);
  }

  Widget _buildBannerIcon() {
    return Container(
      width: 70.w,
      height: 70.w,
      margin: const EdgeInsets.only(right: 10).r,
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
    );
  }
}
