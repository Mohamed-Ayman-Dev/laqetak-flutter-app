import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invastro/src/core/constants/string_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../generated/l10n.dart';
import '../../../features/home/presentation/screens/home_layout_screen.dart';
import '../../di/locator_service.dart';
import '../../helpers/navigation_helper.dart';
import '../../network/api_service.dart';
import '../controllers/settings_controller.dart';
import '../models/settings_model.dart';
import '../widgets/timeout_splashscreen.dart';

class AppSettings with ChangeNotifier {
  String language = StringManager.arLanguageCode;
  ThemeMode themeMode = ThemeMode.system;
  int homeIndex = 0;
  int ordersTabIndex = 0;
  SettingsModel? mySettings;
  bool loadingSettings = false;
  String urlType = 'production'; //production or preproduction or develop
  Future<void> setUrlType(String type) async {
    ApiService.baseOptions.baseUrl = (type == 'develop')
        ? 'https://invastro.dev4.wady.sa/api/v1/customer'
        : 'https://invastro.dev4.wady.sa/api/v1/customer';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('urlType', type);
    urlType = type;
    notifyListeners();
    SettingsController.getGeneralSettings();
  }

  void setSettings(SettingsModel settings) {
    mySettings = settings;
    notifyListeners();
  }

  void setLoadingSettings(bool loading) {
    loadingSettings = loading;
    notifyListeners();
  }

  void changeHomeIndex(int index) {
    if (homeIndex == index) return;
    homeIndex = index;
    notifyListeners();
  }

  void changeOrdersTabIndex(int index) {
    if (ordersTabIndex == index) return;
    ordersTabIndex = index;
    notifyListeners();
  }

  void changeLanguageInUi(
    BuildContext context,
    String languageCode, {
    bool showSplashScreen = true,
  }) {
    if (Intl.getCurrentLocale() != languageCode) {
      if (showSplashScreen) {
        Navigator.of(context)
            .push(
              NavigationHelper.slideRightRouteBuilder(
                context,
                const TimeoutSplashScreen(),
                const Duration(milliseconds: 600),
                {'timeout': const Duration(seconds: 1)},
                TimeoutSplashScreen.routeName,
              ),
            )
            .then((_) async {
              await changeLanguage(languageCode);
              LocatorService.navigationService.currentState!
                  .pushNamedAndRemoveUntil(
                    HomeLayoutScreen.routeName,
                    (route) => false,
                  );
              //make to do
              // TODO:
              // PackagesController.getOneWashPackages();
              // PackagesController.getPackages();
            });
      } else {
        changeLanguage(languageCode);
      }
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', newLanguage);
    await S.load(Locale(newLanguage));
    language = newLanguage;
    ApiService.setLanguage(language);
    notifyListeners();
  }

  Future<void> getStoredLanguage() async => await _getStoredLanguage();

  Future<void> getStoredLanguageAndTheme() async =>
      await _getStoredLanguageAndTheme();

  Future<void> _getStoredLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('language')) {
      language = prefs.getString('language') ?? StringManager.arLanguageCode;
    }
    notifyListeners();
  }

  Future<bool> hasStoredLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('language');
  }

  Future<bool> _getStoredLanguageAndTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    late bool hasLanguage;
    if (prefs.containsKey('language')) {
      language = prefs.getString('language') ?? StringManager.arLanguageCode;
      ApiService.setLanguage(language);
      S.load(Locale(language));
      hasLanguage = true;
    } else {
      prefs.setString('language', language);
      ApiService.setLanguage(language);
      S.load(Locale(language));
      hasLanguage = false;
    }
    themeMode = ThemeMode.light;
    if (prefs.containsKey('urlType')) {
      urlType = prefs.getString('urlType') ?? 'production';
      ApiService.baseOptions.baseUrl = (urlType == 'develop')
          ? 'https://invastro.dev4.wady.sa/api/v1/customer'
          : 'https://invastro.dev4.wady.sa/api/v1/customer';
    }

    // if (prefs.containsKey('themeMode')) {
    //   final int tm = prefs.getInt('themeMode') ?? 0;
    //   themeMode = tm == 0
    //       ? ThemeMode.system
    //       : tm == 1
    //           ? ThemeMode.dark
    //           : ThemeMode.light;
    // }
    notifyListeners();
    return hasLanguage;
  }

  Future<void> changeThemeMode(ThemeMode tm) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(
      'themeMode',
      tm == ThemeMode.system
          ? 0
          : tm == ThemeMode.dark
          ? 1
          : -1,
    );
    themeMode = tm;
    notifyListeners();
  }

  Future<void> getStoredThemeMode() async => await _getStoredThemeMode();

  Future<void> _getStoredThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('themeMode')) {
      final int? tm = prefs.getInt('themeMode');
      if (tm != null) {
        themeMode = tm == 0
            ? ThemeMode.system
            : tm == 1
            ? ThemeMode.dark
            : ThemeMode.light;
      }
    }
    notifyListeners();
  }

  void setTextEditingControllerValue(
    String value,
    TextEditingController textEditingController,
  ) {
    value = textEditingController.text;
    notifyListeners();
  }

  void resetAppSettingsForLogOut() {
    homeIndex = 0;
    ordersTabIndex = 0;
  }
}
