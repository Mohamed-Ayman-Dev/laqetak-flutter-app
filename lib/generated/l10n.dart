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

  /// `Please allow notifications permission to get updates in settings`
  String get pleaseAllowNotificationsPermissionToGetUpdatesInSettings {
    return Intl.message(
      'Please allow notifications permission to get updates in settings',
      name: 'pleaseAllowNotificationsPermissionToGetUpdatesInSettings',
      desc: '',
      args: [],
    );
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

  /// `Sending Request...`
  String get sendingRequest {
    return Intl.message(
      'Sending Request...',
      name: 'sendingRequest',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forgotYourPassword {
    return Intl.message(
      'Forgot your password?',
      name: 'forgotYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number, username, or email to reset your password. A verification code will be sent via SMS.`
  String get enterYourPhoneNumberUsernameOrEmailToResetYour {
    return Intl.message(
      'Enter your phone number, username, or email to reset your password. A verification code will be sent via SMS.',
      name: 'enterYourPhoneNumberUsernameOrEmailToResetYour',
      desc: '',
      args: [],
    );
  }

  /// `Email or mobile number or username`
  String get emailOrMobileNumberOrUsername {
    return Intl.message(
      'Email or mobile number or username',
      name: 'emailOrMobileNumberOrUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter your login details`
  String get enterYourLoginDetails {
    return Intl.message(
      'Enter your login details',
      name: 'enterYourLoginDetails',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `Don’t have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Verify your identity`
  String get verifyYourIdentity {
    return Intl.message(
      'Verify your identity',
      name: 'verifyYourIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your phone number`
  String get pleaseVerifyYourPhoneNumber {
    return Intl.message(
      'Please verify your phone number',
      name: 'pleaseVerifyYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Changes have been saved successfully`
  String get changesHaveBeenSavedSuccessfully {
    return Intl.message(
      'Changes have been saved successfully',
      name: 'changesHaveBeenSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Verify your phone number`
  String get verifyYourPhoneNumber {
    return Intl.message(
      'Verify your phone number',
      name: 'verifyYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Continue to sign in`
  String get continueToSignIn {
    return Intl.message(
      'Continue to sign in',
      name: 'continueToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter the verification code we sent to`
  String get enterTheVerificationCodeWeSentTo {
    return Intl.message(
      'Enter the verification code we sent to',
      name: 'enterTheVerificationCodeWeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `to continue resetting your password`
  String get toContinueResettingYourPassword {
    return Intl.message(
      'to continue resetting your password',
      name: 'toContinueResettingYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `to complete your account creation`
  String get toCompleteYourAccountCreation {
    return Intl.message(
      'to complete your account creation',
      name: 'toCompleteYourAccountCreation',
      desc: '',
      args: [],
    );
  }

  /// `to sign in`
  String get toSignIn {
    return Intl.message('to sign in', name: 'toSignIn', desc: '', args: []);
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Set a new password for your account. Choose a strong and memorable password.`
  String get setANewPasswordForYourAccountChooseAStrong {
    return Intl.message(
      'Set a new password for your account. Choose a strong and memorable password.',
      name: 'setANewPasswordForYourAccountChooseAStrong',
      desc: '',
      args: [],
    );
  }

  /// `Save Password`
  String get savePassword {
    return Intl.message(
      'Save Password',
      name: 'savePassword',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
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

  /// `Didn’t receive the code`
  String get didntReceiveTheCode {
    return Intl.message(
      'Didn’t receive the code',
      name: 'didntReceiveTheCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
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

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
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

  /// `Select City`
  String get selectCity {
    return Intl.message('Select City', name: 'selectCity', desc: '', args: []);
  }

  /// `your phone number`
  String get yourPhoneNumber {
    return Intl.message(
      'your phone number',
      name: 'yourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has been sent to your phone`
  String get verificationCodeHasBeenSentToYourPhone {
    return Intl.message(
      'Verification code has been sent to your phone',
      name: 'verificationCodeHasBeenSentToYourPhone',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Attachments`
  String get attachments {
    return Intl.message('Attachments', name: 'attachments', desc: '', args: []);
  }

  /// `Invastro User`
  String get invastroUser {
    return Intl.message(
      'Invastro User',
      name: 'invastroUser',
      desc: '',
      args: [],
    );
  }

  /// `Open Settings`
  String get openSettings {
    return Intl.message(
      'Open Settings',
      name: 'openSettings',
      desc: '',
      args: [],
    );
  }

  /// `Tap to retry`
  String get tapToRetry {
    return Intl.message('Tap to retry', name: 'tapToRetry', desc: '', args: []);
  }

  /// `Adjust Image`
  String get adjustImage {
    return Intl.message(
      'Adjust Image',
      name: 'adjustImage',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to the terms and conditions`
  String get pleaseAgreeToTheTermsAndConditions {
    return Intl.message(
      'Please agree to the terms and conditions',
      name: 'pleaseAgreeToTheTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Please agree to the idea`
  String get pleaseAgreeToTheIdea {
    return Intl.message(
      'Please agree to the idea',
      name: 'pleaseAgreeToTheIdea',
      desc: '',
      args: [],
    );
  }

  /// `Deleting notification...`
  String get deletingNotification {
    return Intl.message(
      'Deleting notification...',
      name: 'deletingNotification',
      desc: '',
      args: [],
    );
  }

  /// `Notification deleted successfully`
  String get notificationDeletedSuccessfully {
    return Intl.message(
      'Notification deleted successfully',
      name: 'notificationDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `There are no more ads..`
  String get thereAreNoMoreAds {
    return Intl.message(
      'There are no more ads..',
      name: 'thereAreNoMoreAds',
      desc: '',
      args: [],
    );
  }

  /// `There are no description.`
  String get thereAreNoDescription {
    return Intl.message(
      'There are no description.',
      name: 'thereAreNoDescription',
      desc: '',
      args: [],
    );
  }

  /// `There are no ads yet.`
  String get thereAreNoAdsYet {
    return Intl.message(
      'There are no ads yet.',
      name: 'thereAreNoAdsYet',
      desc: '',
      args: [],
    );
  }

  /// `This ad has no images`
  String get thisAdHasNoImages {
    return Intl.message(
      'This ad has no images',
      name: 'thisAdHasNoImages',
      desc: '',
      args: [],
    );
  }

  /// `Submit Complaint`
  String get submitComplaint {
    return Intl.message(
      'Submit Complaint',
      name: 'submitComplaint',
      desc: '',
      args: [],
    );
  }

  /// `Permission Required`
  String get permissionRequired {
    return Intl.message(
      'Permission Required',
      name: 'permissionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please allow access to the gallery in settings.`
  String get pleaseAllowAccessToTheGalleryInSettings {
    return Intl.message(
      'Please allow access to the gallery in settings.',
      name: 'pleaseAllowAccessToTheGalleryInSettings',
      desc: '',
      args: [],
    );
  }

  /// `Select Complaint Reason`
  String get selectComplaintReason {
    return Intl.message(
      'Select Complaint Reason',
      name: 'selectComplaintReason',
      desc: '',
      args: [],
    );
  }

  /// `Complaint Reason`
  String get complaintReason {
    return Intl.message(
      'Complaint Reason',
      name: 'complaintReason',
      desc: '',
      args: [],
    );
  }

  /// `Please select a complaint reason`
  String get pleaseSelectAComplaintReason {
    return Intl.message(
      'Please select a complaint reason',
      name: 'pleaseSelectAComplaintReason',
      desc: '',
      args: [],
    );
  }

  /// `Enter complaint details`
  String get enterComplaintDetails {
    return Intl.message(
      'Enter complaint details',
      name: 'enterComplaintDetails',
      desc: '',
      args: [],
    );
  }

  /// `Write complaint details here...`
  String get writeComplaintDetailsHere {
    return Intl.message(
      'Write complaint details here...',
      name: 'writeComplaintDetailsHere',
      desc: '',
      args: [],
    );
  }

  /// `Please enter complaint details`
  String get pleaseEnterComplaintDetails {
    return Intl.message(
      'Please enter complaint details',
      name: 'pleaseEnterComplaintDetails',
      desc: '',
      args: [],
    );
  }

  /// `There are no conversations yet.`
  String get thereAreNoConversationsYet {
    return Intl.message(
      'There are no conversations yet.',
      name: 'thereAreNoConversationsYet',
      desc: '',
      args: [],
    );
  }

  /// `There are no more conversations.`
  String get thereAreNoMoreConversations {
    return Intl.message(
      'There are no more conversations.',
      name: 'thereAreNoMoreConversations',
      desc: '',
      args: [],
    );
  }

  /// `Press to chat`
  String get pressToChat {
    return Intl.message(
      'Press to chat',
      name: 'pressToChat',
      desc: '',
      args: [],
    );
  }

  /// `There are no messages yet, start a conversation`
  String get thereAreNoMessagesYetStartAConversation {
    return Intl.message(
      'There are no messages yet, start a conversation',
      name: 'thereAreNoMessagesYetStartAConversation',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message('Now', name: 'now', desc: '', args: []);
  }

  /// `Sending...`
  String get sending {
    return Intl.message('Sending...', name: 'sending', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
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
