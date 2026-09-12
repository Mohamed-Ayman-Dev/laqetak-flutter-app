import 'package:flutter/material.dart';
import 'package:invastro/src/core/constants/svg_assets.dart';
import 'package:invastro/src/core/helpers/dialog_helpers.dart';
import 'package:invastro/src/core/shared/controllers/settings_controller.dart';
import 'package:invastro/src/core/widgets/custom_appbar.dart';
import 'package:invastro/src/core/themes/colors.dart';
import 'package:invastro/src/features/chat/presentation/screens/conversations_screen.dart';
import 'package:invastro/src/features/favorite/presentation/screens/favorite_screen.dart';
import 'package:invastro/src/features/notifications/presentation/screens/notification_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/di/locator_service.dart';
import '../../../../core/helpers/others_helper.dart';
import '../../../../core/shared/providers/app_settings.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/widgets/drawer_widgets/custom_drawer.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
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
  final List<Widget> screens = [
    HomeScreen(),
    ConversationsScreen(),
    ConversationsScreen(),
    FavoriteScreen(),
    NotificationScreen(),
  ];
  bool once = false;

  @override
  void didChangeDependencies() {
    if (!once) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (isAuth) {
          AuthController.getProfile();
        }
        if (LocatorService.appSettings.mySettings == null) {
          SettingsController.getGeneralSettings();
        }
        LocatorService.notificationService.initializeFCM();
      });

      once = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {
        'name': S.of(context).home,
        'activeIcon': SvgAssets.assetsSvgHomeIconSelected, // ملون
        'inactiveIcon': SvgAssets.assetsSvgHomeIconUnselected, // رمادي
      },
      {
        'name': S.of(context).chatnavbar,
        'activeIcon': SvgAssets.assetsSvgMessageIconSelected,
        'inactiveIcon': SvgAssets.assetsSvgMessageIconUnselected,
      },
      {'name': 'add', 'activeIcon': null, 'inactiveIcon': null},
      {
        'name': S.of(context).favorites,
        'activeIcon': SvgAssets.assetsSvgFavIconSelected,
        'inactiveIcon': SvgAssets.assetsSvgFavIconUnselected,
      },
      {
        'name': S.of(context).notifications,
        'activeIcon': SvgAssets.assetsSvgNotificationIconSelected,
        'inactiveIcon': SvgAssets.assetsSvgNotificationIconUnselected,
      },
    ];
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

          body: WillPopScope(
            onWillPop: () async {
              if (homeIndex == 0) {
                bool? shouldClose = await DialogHelpers.showConfirmDialog(
                  context: context,
                  title: S.of(context).closeApp,
                  description: S.of(context).areYouSureYouWantToCloseTheApp,
                  buttonText: S.of(context).yes,
                  color: AppColors.primaryColor,
                  onYes: () {
                    LocatorService.navigationService.currentState!.pop(true);
                  },
                );
                return Future.value(shouldClose ?? false);
              } else {
                LocatorService.appSettings.changeHomeIndex(0);
                return Future.value(false);
              }
            },
            child: screens[homeIndex],
          ),
          // ── Bottom Nav ──────────────────────────────────────────────────
          bottomNavigationBar: BottomNavBar(navItems: navItems),
        );
      },
    );
  }
}
