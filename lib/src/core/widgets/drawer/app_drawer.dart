import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laqetak/src/core/constants/svg_assets.dart';
import 'package:laqetak/src/core/di/locator_service.dart';
import 'package:laqetak/src/core/helpers/bottom_helpers.dart';
import 'package:laqetak/src/core/helpers/dialog_helpers.dart';
import 'package:laqetak/src/core/themes/colors.dart';
import 'package:laqetak/src/features/auth/presentation/screens/login_screen.dart';
import 'package:laqetak/src/features/my_ads/presentation/screens/my_ads_screen.dart';
import 'package:laqetak/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:laqetak/src/features/static_pages/presentation/screens/about_app_screen.dart';
import 'package:laqetak/src/features/static_pages/presentation/screens/contact_us_screen.dart';
import 'package:laqetak/src/features/static_pages/presentation/screens/questions_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../features/auth/presentation/cubit/auth_state.dart';
import '../../../features/home/presentation/screens/home_layout_screen.dart';
import '../../constants/app_feedback.dart';
import '../../constants/enums.dart';
import '../../helpers/others_helper.dart';
import 'app_drawer_header.dart';
import 'drawer_item.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0).r,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
              tileMode: TileMode.decal,
            ),
            child: const SizedBox.expand(),
          ),
          Drawer(
            elevation: 20,
            backgroundColor: Colors.white,
            width: 270.w,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: isArabic
                    ? const Radius.circular(0)
                    : const Radius.circular(0),
                bottomLeft: isArabic
                    ? const Radius.circular(50)
                    : const Radius.circular(0),
                topRight: isArabic
                    ? const Radius.circular(0)
                    : const Radius.circular(0),
                bottomRight: isArabic
                    ? const Radius.circular(0)
                    : const Radius.circular(50),
              ),
            ),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  AppDrawerHeader(),
                  Divider(
                    height: 40.h,
                    endIndent: 20.w,
                    indent: 20.w,
                    color: AppColors.drawerDividerColor,
                  ),
                  Padding(
                    padding: isArabic
                        ? const EdgeInsets.only(right: 26).r
                        : const EdgeInsets.only(left: 26).r,
                    child: Column(
                      children: [
                        if (isAuth)
                          DrawerItem(
                            title: S.of(context).profile,
                            onTap: () {
                              Navigator.of(context).pop();
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(ProfileScreen.routeName);
                            },
                            image: SvgAssets.assetsSvgDrawerProfile,
                          ),
                        if (isAuth)
                          DrawerItem(
                            title: S.of(context).myAds,
                            onTap: () {
                              Navigator.of(context).pop();
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(MyAdsScreen.routeName);
                            },
                            image: SvgAssets.assetsSvgDrawerMyads,
                          ),
                        DrawerItem(
                          title: S.of(context).messages,
                          onTap: () {
                            Navigator.of(context).pop();
                            LocatorService.navigationService.currentState
                                ?.popUntil(
                                  (route) =>
                                      route.settings.name ==
                                      HomeLayoutScreen.routeName,
                                );
                            LocatorService.settingsCubit.changeHomeIndex(1);
                          },
                          image: SvgAssets.assetsSvgDrawerMessages,
                        ),
                        DrawerItem(
                          title: S.of(context).contactUs,
                          onTap: () {
                            Navigator.of(context).pop();
                            LocatorService.navigationService.currentState
                                ?.pushNamed(ContactUsScreen.routeName);
                          },
                          image: SvgAssets.assetsSvgDrawerContactus,
                        ),
                        DrawerItem(
                          title: S.of(context).aboutThePlatform,
                          onTap: () {
                            Navigator.of(context).pop();
                            LocatorService.navigationService.currentState
                                ?.pushNamed(AboutAppScreen.routeName);
                          },
                          image: SvgAssets.assetsSvgDrawerAbout,
                        ),

                        DrawerItem(
                          title: S.of(context).language,
                          onTap: () {
                            Navigator.of(context).pop();
                            BottomHelpers.showLanguageBottomSheet(context);
                          },
                          image: SvgAssets.assetsSvgDrawerLang,
                        ),
                        DrawerItem(
                          title: S.of(context).termsConditions,
                          onTap: () {
                            Navigator.of(context).pop();
                            DialogHelpers.showTermsDialog();
                          },
                          image: SvgAssets.assetsSvgDrawerTerms,
                        ),
                        DrawerItem(
                          title: S.of(context).frequentlyAskedQuestions,
                          onTap: () {
                            Navigator.of(context).pop();
                            LocatorService.navigationService.currentState
                                ?.pushNamed(QuestionsScreen.routeName);
                          },
                          image: SvgAssets.assetsSvgDrawerQuestions,
                        ),
                        DrawerItem(
                          title: isAuth
                              ? S.of(context).logout
                              : S.of(context).login,
                          onTap: () async {
                            if (!isAuth) {
                              LocatorService.navigationService.currentState
                                  ?.popUntil(
                                    (route) =>
                                        route.settings.name ==
                                        LoginScreen.routeName,
                                  );
                              return;
                            }
                            AppFeedback.loadingMessage();
                            await LocatorService.authCubit.logout();
                            EasyLoading.dismiss();
                            final authState = LocatorService.authCubit.state;
                            if (authState.lastMutation != AuthMutation.logout) {
                              return;
                            }
                            if (authState.actionStatus == RequestStatus.error) {
                              AppFeedback.errorMessage(authState.errorMessage);
                              return;
                            }
                            if (authState.actionStatus !=
                                RequestStatus.success) {
                              return;
                            }
                            LocatorService.resetSessionCubits();
                            LocatorService.navigationService.currentState
                                ?.pushNamedAndRemoveUntil(
                                  LoginScreen.routeName,
                                  (route) => false,
                                );
                          },
                          image: SvgAssets.assetsSvgDrawerSignout,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
