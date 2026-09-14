import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/config/routes.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import '../../generated/l10n.dart';
import '../core/constants/app_feedback.dart';
import '../core/constants/enums.dart';
import '../core/constants/images_assets.dart';
import '../core/di/locator_service.dart';
import '../core/helpers/dialog_helpers.dart';
import '../core/shared/settings/presentation/cubit/settings_cubit.dart';
import '../core/shared/settings/presentation/cubit/settings_state.dart';
import '../core/themes/theme.dart';
import '../features/home/presentation/cubit/ads_cubit.dart';
import '../features/home/presentation/cubit/ads_state.dart';
import '../features/auth/presentation/cubit/auth_cubit.dart';
import '../features/auth/presentation/cubit/auth_state.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/home/presentation/screens/home_layout_screen.dart';
import '../features/my_ads/presentation/cubit/my_ads_cubit.dart';
import '../features/my_ads/presentation/cubit/my_ads_state.dart';
import '../features/my_ads/presentation/screens/add_ad_pay_screen.dart';
import '../core/shared/models/redirect_model.dart';
import 'app_providers.dart';

void _resetFeatureCubits() {
  LocatorService.settingsCubit.resetOnLogout();
  LocatorService.adsCubit.resetOnLogout();
  LocatorService.myAdsCubit.resetOnLogout();
  LocatorService.adDetailsCubit.resetOnLogout();
  LocatorService.chatCubit.resetOnLogout();
  LocatorService.notificationsCubit.clear();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // separate file: core/utils/asset_precache.dart
  Future<void> precacheAssets(BuildContext context) async {
    await Future.wait([
      precacheImage(
        const AssetImage(ImagesAssets.assetsImagesSplashImage),
        context,
      ),
      precacheImage(const AssetImage(ImagesAssets.assetsImagesLogo), context),
    ]);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheAssets(context);
    });
  }

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: Size(375, 812),
      splitScreenMode: true,
      fontSizeResolver: (fontSize, instance) {
        final scale = instance.scaleWidth.clamp(0.85, 1.15);
        return fontSize * scale;
      },
      child: MultiBlocProvider(
        providers: AppBlocProviders.providers,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (previous, current) =>
              previous.language != current.language ||
              previous.themeMode != current.themeMode ||
              previous.urlType != current.urlType,
          builder: (BuildContext context, state) {
            return MultiBlocListener(
              listeners: [
                BlocListener<AdsCubit, AdsState>(
                  listenWhen: (previous, current) =>
                      previous.favoriteEventId != current.favoriteEventId,
                  listener: (context, adsState) {
                    final added = adsState.favoriteAdded ?? false;
                    AppFeedback.showToast(
                      "${adsState.favoriteTitle ?? ''} ${added ? S.current.added : S.current.removed} ${added ? S.current.toFavoritesSuccessfully : S.current.fromFavoritesSuccessfully}",
                    );
                  },
                ),
                BlocListener<AdsCubit, AdsState>(
                  listenWhen: (previous, current) =>
                      previous.complaintStatus != current.complaintStatus,
                  listener: (context, adsState) {
                    switch (adsState.complaintStatus) {
                      case RequestStatus.loading:
                        AppFeedback.loadingMessage();
                      case RequestStatus.success:
                        EasyLoading.dismiss();
                        DialogHelpers.showSuccessDialog(
                          title: adsState.complaintTarget == ComplaintTarget.ad
                              ? S.current.reportSubmittedSuccessfully
                              : S.current.reportSentSuccessfully,
                        );
                      case RequestStatus.error:
                        AppFeedback.errorMessage(adsState.errorMessage);
                      case RequestStatus.initial:
                        break;
                    }
                  },
                ),
                BlocListener<AdsCubit, AdsState>(
                  listenWhen: (previous, current) =>
                      current.errorMessage != null &&
                      current.errorMessage != previous.errorMessage &&
                      current.complaintStatus != RequestStatus.error,
                  listener: (context, adsState) {
                    AppFeedback.errorMessage(adsState.errorMessage);
                  },
                ),
                BlocListener<MyAdsCubit, MyAdsState>(
                  listenWhen: (previous, current) =>
                      previous.actionStatus != current.actionStatus,
                  listener: (context, myAdsState) {
                    switch (myAdsState.actionStatus) {
                      case RequestStatus.loading:
                        if (myAdsState.lastMutation == MyAdsMutation.otp &&
                            myAdsState.otpResent) {
                          break;
                        }
                        AppFeedback.loadingMessage();
                      case RequestStatus.success:
                        EasyLoading.dismiss();
                        switch (myAdsState.lastMutation) {
                          case MyAdsMutation.add:
                            if (myAdsState.createdAd != null) {
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    AddAdPayScreen.routeName,
                                    arguments: myAdsState.createdAd,
                                  );
                            }
                          case MyAdsMutation.edit:
                            DialogHelpers.showSuccessDialog(
                              title: S
                                  .current
                                  .congratulationsYourAdEditRequestHasBeenSubmittedSuccessfully,
                              subtitle: S
                                  .current
                                  .yourRequestWillBeReviewedByTheAdministrationAndIf,
                            );
                          case MyAdsMutation.delete:
                            LocatorService.adsCubit.getAds(refresh: true);
                            DialogHelpers.showSuccessDialog(
                              title: S.current.adDeletedSuccessfully,
                            );
                          case MyAdsMutation.close:
                            final id = myAdsState.lastAdId;
                            if (id != null) {
                              LocatorService.adsCubit.getAdDetails(id);
                            }
                            LocatorService.adsCubit.getAds(refresh: true);
                            DialogHelpers.showSuccessDialog(
                              title: S.current.adEndedSuccessfully,
                            );
                          case MyAdsMutation.otp:
                            if (myAdsState.otpResent) {
                              AppFeedback.showToast(
                                S
                                    .current
                                    .verificationCodeHasBeenSentToYourPhone,
                              );
                            } else {
                              if (myAdsState.otpMessage != null) {
                                AppFeedback.showToast(myAdsState.otpMessage!);
                              }
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    OtpScreen.routeName,
                                    arguments: {
                                      'redirectData':
                                          myAdsState.otpRedirect ??
                                          RedirectModel(),
                                      'data': myAdsState.otpFormData,
                                      'from': myAdsState.otpIsEdit
                                          ? OtpFlow.editAd
                                          : OtpFlow.addAd,
                                    },
                                  );
                            }
                          case MyAdsMutation.pay:
                          case MyAdsMutation.none:
                            break;
                        }
                      case RequestStatus.error:
                        if (myAdsState.verificationErrorMessage != null) {
                          EasyLoading.dismiss();
                          LocatorService.authCubit.setWrongVerificationCode(
                            myAdsState.verificationErrorMessage,
                          );
                          Future.delayed(const Duration(milliseconds: 100), () {
                            LocatorService
                                .authCubit
                                .activationFormKey
                                .currentState
                                ?.validate();
                          });
                        } else {
                          AppFeedback.errorMessage(myAdsState.errorMessage);
                        }
                      case RequestStatus.initial:
                        break;
                    }
                  },
                ),
                BlocListener<AuthCubit, AuthState>(
                  listenWhen: (previous, current) =>
                      previous.actionStatus != current.actionStatus,
                  listener: (context, authState) {
                    switch (authState.actionStatus) {
                      case RequestStatus.loading:
                        if (authState.otpResent ||
                            authState.lastMutation ==
                                AuthMutation.registerOtpResend) {
                          break;
                        }
                        if (authState.lastMutation ==
                            AuthMutation.deleteAccount) {
                          LocatorService.navigationService.currentState?.pop();
                          AppFeedback.loadingMessage(
                            message: S.current.deletingAccount,
                          );
                        } else {
                          AppFeedback.loadingMessage();
                        }
                      case RequestStatus.success:
                        EasyLoading.dismiss();
                        switch (authState.lastMutation) {
                          case AuthMutation.login:
                            if (authState.otpResent) {
                              AppFeedback.showToast(
                                S
                                    .current
                                    .verificationCodeHasBeenSentToYourPhone,
                              );
                            } else if (authState.otpRedirect != null) {
                              AppFeedback.showToast(
                                S.current.pleaseVerifyYourPhoneNumber,
                              );
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    OtpScreen.routeName,
                                    arguments: {
                                      'redirectData': authState.otpRedirect,
                                      'data': authState.otpFormData,
                                      'from': OtpFlow.login,
                                    },
                                  );
                            } else {
                              LocatorService.navigationService.currentState
                                  ?.pushNamedAndRemoveUntil(
                                    HomeLayoutScreen.routeName,
                                    (route) => false,
                                  );
                              if (LocatorService
                                      .settingsCubit
                                      .state
                                      .homeIndex !=
                                  0) {
                                LocatorService.settingsCubit.changeHomeIndex(0);
                              }
                            }
                          case AuthMutation.register:
                            if (authState.otpResent) {
                              AppFeedback.showToast(
                                S
                                    .current
                                    .verificationCodeHasBeenSentToYourPhone,
                              );
                            } else if (authState.otpRedirect != null) {
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    OtpScreen.routeName,
                                    arguments: {
                                      'redirectData': authState.otpRedirect,
                                      'data': authState.otpFormData,
                                      'from': OtpFlow.register,
                                    },
                                  );
                            }
                          case AuthMutation.registerOtp:
                            DialogHelpers.showSuccessDialog(
                              title: S
                                  .current
                                  .congratulationsYourAccountHasBeenRegisteredSuccessfully,
                              onButtonTap: () {
                                LocatorService.navigationService.currentState
                                    ?.pop();
                              },
                            )?.then((_) {
                              if (authState.otpVerified) {
                                LocatorService.navigationService.currentState
                                    ?.pushNamedAndRemoveUntil(
                                      HomeLayoutScreen.routeName,
                                      (route) => false,
                                    );
                              }
                            });
                          case AuthMutation.registerOtpResend:
                            AppFeedback.showToast(
                              S.current.verificationCodeHasBeenSentToYourPhone,
                            );
                          case AuthMutation.sendPhoneOtp:
                            if (authState.otpResent) {
                              AppFeedback.showToast(
                                S
                                    .current
                                    .verificationCodeHasBeenSentToYourPhone,
                              );
                            } else if (authState.otpRedirect != null) {
                              if (authState.successMessage != null) {
                                AppFeedback.showToast(
                                  authState.successMessage!,
                                );
                              }
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    OtpScreen.routeName,
                                    arguments: {
                                      'redirectData': authState.otpRedirect,
                                      'data': authState.otpFormData,
                                      'from': OtpFlow.updatePhone,
                                    },
                                  );
                            }
                          case AuthMutation.logout:
                            _resetFeatureCubits();
                            LocatorService.navigationService.currentState
                                ?.pushNamedAndRemoveUntil(
                                  LoginScreen.routeName,
                                  (route) => false,
                                );
                          case AuthMutation.deleteAccount:
                            _resetFeatureCubits();
                            FirebaseAnalytics.instance.setUserId(id: null);
                            FirebaseCrashlytics.instance.setUserIdentifier('');
                            LocatorService.navigationService.currentState
                                ?.pushNamedAndRemoveUntil(
                                  LoginScreen.routeName,
                                  (route) => false,
                                );
                            DialogHelpers.showSuccessDialog(
                              title: S.current.accountDeletedSuccessfully,
                              buttonText: S.current.login,
                              onButtonTap: () {
                                LocatorService.navigationService.currentState
                                    ?.popUntil(
                                      (route) =>
                                          route.settings.name ==
                                          LoginScreen.routeName,
                                    );
                              },
                            );
                          case AuthMutation.forgetPassword:
                            AppFeedback.showToast(
                              S.current.verificationCodeHasBeenSentToYourPhone,
                            );
                            if (!authState.otpResent && authState.otpVerified) {
                              LocatorService.navigationService.currentState
                                  ?.pushNamed(
                                    OtpScreen.routeName,
                                    arguments: {
                                      'redirectData':
                                          authState.otpRedirect ??
                                          RedirectModel(),
                                      'from': OtpFlow.forgetPassword,
                                    },
                                  );
                            }
                          case AuthMutation.forgetPasswordOtp:
                            LocatorService.navigationService.currentState
                                ?.pushNamed(
                                  ResetPasswordScreen.routeName,
                                  arguments: {
                                    'phone': authState.otpFormData?['phone'],
                                    'code': authState.otpFormData?['code'],
                                  },
                                );
                          case AuthMutation.resetPassword:
                            DialogHelpers.showSuccessDialog(
                              title: S.current.passwordChangedSuccessfully,
                              buttonText: S.current.login,
                              onButtonTap: () {
                                LocatorService.navigationService.currentState
                                    ?.pop();
                              },
                            )?.then((_) {
                              LocatorService.navigationService.currentState
                                  ?.popUntil(
                                    (route) =>
                                        route.settings.name ==
                                        LoginScreen.routeName,
                                  );
                            });
                          case AuthMutation.updateProfile:
                            DialogHelpers.showSuccessDialog(
                              title:
                                  authState.successMessage ??
                                  S
                                      .current
                                      .congratulationsYourProfileHasBeenUpdatedSuccessfully,
                            );
                          case AuthMutation.none:
                            break;
                        }
                      case RequestStatus.error:
                        if (authState.verificationErrorMessage != null) {
                          EasyLoading.dismiss();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            LocatorService
                                .authCubit
                                .activationFormKey
                                .currentState
                                ?.validate();
                          });
                        } else {
                          AppFeedback.errorMessage(authState.errorMessage);
                        }
                      case RequestStatus.initial:
                        break;
                    }
                  },
                ),
                BlocListener<AuthCubit, AuthState>(
                  listenWhen: (previous, current) =>
                      current.errorMessage != null &&
                      current.errorMessage != previous.errorMessage &&
                      current.actionStatus != RequestStatus.error,
                  listener: (context, authState) {
                    AppFeedback.errorMessage(authState.errorMessage);
                  },
                ),
              ],
              child: MaterialApp(
                navigatorKey: LocatorService.navigationService.navigatorKey,
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return Stack(
                    children: [
                      EasyLoading.init(
                        builder: state.urlType == 'production'
                            ? null
                            : (context, child) {
                                return Banner(
                                  message: 'Develop',
                                  location: BannerLocation.topEnd,
                                  child: child,
                                );
                              },
                      )(context, child),
                    ],
                  );
                },
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(state.language, ''),
                title: 'Invastro',
                color: Colors.white,
                themeMode: state.themeMode,
                theme: CustomTheme.lightTheme,
                navigatorObservers: [
                  FirebaseAnalyticsObserver(analytics: _analytics),
                  NavigationHistoryObserver(),
                ],
                initialRoute: Routes.initialRoute,
                routes: Routes.routes,
              ),
            );
          },
        ),
      ),
    );
  }
}
