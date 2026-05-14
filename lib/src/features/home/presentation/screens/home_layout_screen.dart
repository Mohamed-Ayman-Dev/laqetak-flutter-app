import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/shared/widgets/custom_appbar.dart';
import 'package:invastro/src/features/chat/presentation/screens/conversations_screen.dart';
import 'package:invastro/src/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:invastro/src/features/notifications/presentation/screens/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/providers/app_settings.dart';
import '../../../../core/shared/widgets/bottom_nav_bar.dart';
import '../../../../core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'home_screen.dart';

class HomeLayoutScreen extends StatefulWidget {
  static const routeName = '/home_layout_screen';
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  final List<Map<String, dynamic>> _navItems = [
    {
      'name': 'الرئيسية',
      'activeIcon': SvgAssets.assetsSvgHomeIconSelected, // ملون
      'inactiveIcon': SvgAssets.assetsSvgHomeIconUnselected, // رمادي
    },
    {
      'name': 'الرسائل',
      'activeIcon': SvgAssets.assetsSvgMessageIconSelected,
      'inactiveIcon': SvgAssets.assetsSvgMessageIconUnselected,
    },
    {'name': 'add', 'activeIcon': null, 'inactiveIcon': null},
    {
      'name': 'المفضلة',
      'activeIcon': SvgAssets.assetsSvgFavIconSelected,
      'inactiveIcon': SvgAssets.assetsSvgFavIconUnselected,
    },
    {
      'name': 'الإشعارات',
      'activeIcon': SvgAssets.assetsSvgNotificationIconSelected,
      'inactiveIcon': SvgAssets.assetsSvgNotificationIconUnselected,
    },
  ];
  final List<Widget> screens = [
    HomeScreen(),
    ConversationsScreen(),
    ConversationsScreen(),
    FavoriteScreen(),
    NotificationScreen(),
  ];
  bool dialogShown = false;
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (isAuth) {
          // AuthController.getProfile();
        }
        if (LocatorService.appSettings.mySettings?.currentStage == null) {
          // AuthController.getGeneralSettings();
        }
        // LocatorService.notificationService.initializeFCM();
        initPermission();
        askNotificationPermission();
        if (isAuth) {
          // final token = await AuthController.getDeviceToken();
          // if (token != null) {
          //   AuthController.sendDeviceToken(token);
          // }
        }
      });

      once = true;
    }
    super.didChangeDependencies();
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> initPermission() async {
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

  bool permissionChecked = false;

  Future<void> askNotificationPermission() async {
    // if (permissionChecked) return;
    // permissionChecked = true; // Mark as checked
    //
    // final PermissionStatus currentStatus = await Permission.notification.status;
    // if (currentStatus.isGranted) {
    //   return;
    // }
    // if (currentStatus.isDenied || currentStatus.isPermanentlyDenied) {
    //   final PermissionStatus newStatus = await Permission.notification
    //       .request();
    //   if (newStatus.isGranted) {
    //     initPermission();
    //   } else if (newStatus.isDenied) {
    //     if (mounted) {
    //       EasyLoading.showToast(
    //         S
    //             .of(context)
    //             .pleaseAllowNotificationsPermissionToGetUpdatesInSettings,
    //         dismissOnTap: true,
    //         toastPosition: EasyLoadingToastPosition.bottom,
    //         duration: const Duration(seconds: 3),
    //       );
    //     }
    //   } else if (newStatus.isPermanentlyDenied) {}
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<AppSettings, int>(
      selector: (_, p) => p.homeIndex,
      builder: (context, homeIndex, _) {
        return Scaffold(
          key: HomeLayoutScreen.scaffoldKey,
          // ← أضف الـ key
          appBar: homeIndex == 0
              ? null
              : CustomAppbar(
                  ishHomeLayoutDrawer: true,
                  icons: [AppbarIcons.drawer, AppbarIcons.logo],
                  dontShowBackButton: true,
                ),
          extendBody: true,
          drawer: const CustomDrawer(),

          body: PopScope(canPop: true, child: screens[homeIndex]),
          // ── Bottom Nav ──────────────────────────────────────────────────
          bottomNavigationBar: BottomNavBar(navItems: _navItems),
        );
      },
    );
  }
}
