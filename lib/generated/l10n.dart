// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Username Or Password Is Incorrect`
  String get usernameOrPasswordIsIncorrect {
    return Intl.message(
      'Username Or Password Is Incorrect',
      name: 'usernameOrPasswordIsIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Session Expired Please Login Again`
  String get sessionExpiredPleaseLoginAgain {
    return Intl.message(
      'Session Expired Please Login Again',
      name: 'sessionExpiredPleaseLoginAgain',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error Please Check Your Internet Connection`
  String get connectionErrorPleaseCheckYourInternetConnection {
    return Intl.message(
      'Connection Error Please Check Your Internet Connection',
      name: 'connectionErrorPleaseCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait...`
  String get pleaseWait {
    return Intl.message(
      'Please Wait...',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get pleaseEnterAPhoneNumber {
    return Intl.message(
      'Please enter a phone number',
      name: 'pleaseEnterAPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number should be at least 9 characters`
  String get phoneNumberShouldBeAtLeast9Characters {
    return Intl.message(
      'Phone number should be at least 9 characters',
      name: 'phoneNumberShouldBeAtLeast9Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get pleaseEnterAValidPhoneNumber {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'pleaseEnterAValidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password cannot be empty`
  String get passwordCannotBeEmpty {
    return Intl.message(
      'Password cannot be empty',
      name: 'passwordCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password should be at least 8 characters`
  String get passwordShouldBeAtLeast8Characters {
    return Intl.message(
      'Password should be at least 8 characters',
      name: 'passwordShouldBeAtLeast8Characters',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password confirmation`
  String get pleaseEnterAPasswordConfirmation {
    return Intl.message(
      'Please enter a password confirmation',
      name: 'pleaseEnterAPasswordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Write the reason`
  String get writeTheReason {
    return Intl.message(
      'Write the reason',
      name: 'writeTheReason',
      desc: '',
      args: [],
    );
  }

  /// `Iban do not match`
  String get ibanDoNotMatch {
    return Intl.message(
      'Iban do not match',
      name: 'ibanDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter iban confirmation`
  String get pleaseEnterIbanConfirmation {
    return Intl.message(
      'Please enter iban confirmation',
      name: 'pleaseEnterIbanConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation reason is required`
  String get cancellationReasonIsRequired {
    return Intl.message(
      'Cancellation reason is required',
      name: 'cancellationReasonIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter verification code`
  String get pleaseEnterVerificationCode {
    return Intl.message(
      'Please enter verification code',
      name: 'pleaseEnterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Password should contain only English letters and numbers`
  String get passwordShouldContainOnlyEnglishLettersAndNumbers {
    return Intl.message(
      'Password should contain only English letters and numbers',
      name: 'passwordShouldContainOnlyEnglishLettersAndNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `There are no more notifications`
  String get thereAreNoMoreNotifications {
    return Intl.message(
      'There are no more notifications',
      name: 'thereAreNoMoreNotifications',
      desc: '',
      args: [],
    );
  }

  /// `There are no notifications yet`
  String get thereAreNoNotificationsYet {
    return Intl.message(
      'There are no notifications yet',
      name: 'thereAreNoNotificationsYet',
      desc: '',
      args: [],
    );
  }

  /// `There are no questions yet`
  String get thereAreNoQuestionsYet {
    return Intl.message(
      'There are no questions yet',
      name: 'thereAreNoQuestionsYet',
      desc: '',
      args: [],
    );
  }

  /// `There are no more questions yet`
  String get thereAreNoMoreQuestionsYet {
    return Intl.message(
      'There are no more questions yet',
      name: 'thereAreNoMoreQuestionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Your message has been sent successfully`
  String get yourMessageHasBeenSentSuccessfully {
    return Intl.message(
      'Your message has been sent successfully',
      name: 'yourMessageHasBeenSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Message is required`
  String get messageIsRequired {
    return Intl.message(
      'Message is required',
      name: 'messageIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `There are no favorite stores yet`
  String get thereAreNoFavoriteStoresYet {
    return Intl.message(
      'There are no favorite stores yet',
      name: 'thereAreNoFavoriteStoresYet',
      desc: '',
      args: [],
    );
  }

  /// `From Favorites Successfully`
  String get fromFavoritesSuccessfully {
    return Intl.message(
      'From Favorites Successfully',
      name: 'fromFavoritesSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `There are no more reviews`
  String get thereAreNoMoreReviews {
    return Intl.message(
      'There are no more reviews',
      name: 'thereAreNoMoreReviews',
      desc: '',
      args: [],
    );
  }

  /// `Please select a region`
  String get pleaseSelectARegion {
    return Intl.message(
      'Please select a region',
      name: 'pleaseSelectARegion',
      desc: '',
      args: [],
    );
  }

  /// `Please select a city`
  String get pleaseSelectACity {
    return Intl.message(
      'Please select a city',
      name: 'pleaseSelectACity',
      desc: '',
      args: [],
    );
  }

  /// `Your address has been added successfully`
  String get yourAddressHasBeenAddedSuccessfully {
    return Intl.message(
      'Your address has been added successfully',
      name: 'yourAddressHasBeenAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your address has been edited successfully`
  String get yourAddressHasBeenEditedSuccessfully {
    return Intl.message(
      'Your address has been edited successfully',
      name: 'yourAddressHasBeenEditedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Search for a location`
  String get searchForALocation {
    return Intl.message(
      'Search for a location',
      name: 'searchForALocation',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Please enter your username`
  String get pleaseEnterYourUsername {
    return Intl.message(
      'Please enter your username',
      name: 'pleaseEnterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid name`
  String get pleaseEnterAValidName {
    return Intl.message(
      'Please enter a valid name',
      name: 'pleaseEnterAValidName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get pleaseEnterYourEmail {
    return Intl.message(
      'Please Enter Your Email',
      name: 'pleaseEnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterAValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterAValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `You logged in successfully`
  String get youLoggedInSuccessfully {
    return Intl.message(
      'You logged in successfully',
      name: 'youLoggedInSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
