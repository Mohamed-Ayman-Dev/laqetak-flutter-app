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

  /// `Log In`
  String get logIn {
    return Intl.message('Log In', name: 'logIn', desc: '', args: []);
  }

  /// `Deleting Account`
  String get deletingAccount {
    return Intl.message(
      'Deleting Account',
      name: 'deletingAccount',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get areYouSureYouWantToDeleteYourAccount {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'areYouSureYouWantToDeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been deleted successfully`
  String get yourAccountHasBeenDeletedSuccessfully {
    return Intl.message(
      'Your account has been deleted successfully',
      name: 'yourAccountHasBeenDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to close the app?`
  String get areYouSureYouWantToCloseTheApp {
    return Intl.message(
      'Are you sure you want to close the app?',
      name: 'areYouSureYouWantToCloseTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Close App`
  String get closeApp {
    return Intl.message('Close App', name: 'closeApp', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
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

  /// `Laqetak User`
  String get laqetakUser {
    return Intl.message(
      'Laqetak User',
      name: 'laqetakUser',
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

  /// `Removed`
  String get removed {
    return Intl.message('Removed', name: 'removed', desc: '', args: []);
  }

  /// `Added`
  String get added {
    return Intl.message('Added', name: 'added', desc: '', args: []);
  }

  /// `To Favorites Successfully`
  String get toFavoritesSuccessfully {
    return Intl.message(
      'To Favorites Successfully',
      name: 'toFavoritesSuccessfully',
      desc: '',
      args: [],
    );
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

  /// `There are no favorite ads yet`
  String get thereAreNoFavoriteAdsYet {
    return Intl.message(
      'There are no favorite ads yet',
      name: 'thereAreNoFavoriteAdsYet',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get pleaseSelectACategory {
    return Intl.message(
      'Please select a category',
      name: 'pleaseSelectACategory',
      desc: '',
      args: [],
    );
  }

  /// `Please select a sector`
  String get pleaseSelectASector {
    return Intl.message(
      'Please select a sector',
      name: 'pleaseSelectASector',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your price`
  String get pleaseEnterYourPrice {
    return Intl.message(
      'Please enter your price',
      name: 'pleaseEnterYourPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter ad name`
  String get pleaseEnterAdName {
    return Intl.message(
      'Please enter ad name',
      name: 'pleaseEnterAdName',
      desc: '',
      args: [],
    );
  }

  /// `Details are required`
  String get detailsAreRequired {
    return Intl.message(
      'Details are required',
      name: 'detailsAreRequired',
      desc: '',
      args: [],
    );
  }

  /// `Number has been verified successfully.`
  String get numberHasBeenVerifiedSuccessfully {
    return Intl.message(
      'Number has been verified successfully.',
      name: 'numberHasBeenVerifiedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Hide phone number`
  String get hidePhoneNumber {
    return Intl.message(
      'Hide phone number',
      name: 'hidePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message('Cash', name: 'cash', desc: '', args: []);
  }

  /// `Online payment`
  String get card {
    return Intl.message('Online payment', name: 'card', desc: '', args: []);
  }

  /// `Login to continue`
  String get loginToContinue {
    return Intl.message(
      'Login to continue',
      name: 'loginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Please log in first to view the content of this page`
  String get pleaseLogInFirstToViewTheContentOfThis {
    return Intl.message(
      'Please log in first to view the content of this page',
      name: 'pleaseLogInFirstToViewTheContentOfThis',
      desc: '',
      args: [],
    );
  }

  /// `You need to sign in to view this page. If you dont have an account, you can create one for free.`
  String get youNeedToSignInToViewThisPageIf {
    return Intl.message(
      'You need to sign in to view this page. If you dont have an account, you can create one for free.',
      name: 'youNeedToSignInToViewThisPageIf',
      desc: '',
      args: [],
    );
  }

  /// `By logging in, you can access all the features of the app and enjoy a personalized experience.`
  String get byLoggingInYouCanAccessAllTheFeaturesOf {
    return Intl.message(
      'By logging in, you can access all the features of the app and enjoy a personalized experience.',
      name: 'byLoggingInYouCanAccessAllTheFeaturesOf',
      desc: '',
      args: [],
    );
  }

  /// `SAR`
  String get sar {
    return Intl.message('SAR', name: 'sar', desc: '', args: []);
  }

  /// `More than`
  String get moreThan {
    return Intl.message('More than', name: 'moreThan', desc: '', args: []);
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Check Connection`
  String get checkConnection {
    return Intl.message(
      'Check Connection',
      name: 'checkConnection',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Still no internet connection. Please try again.`
  String get stillNoInternetConnectionPleaseTryAgain {
    return Intl.message(
      'Still no internet connection. Please try again.',
      name: 'stillNoInternetConnectionPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `sec`
  String get second {
    return Intl.message('sec', name: 'second', desc: '', args: []);
  }

  /// `min`
  String get minute {
    return Intl.message('min', name: 'minute', desc: '', args: []);
  }

  /// `hour`
  String get hour {
    return Intl.message('hour', name: 'hour', desc: '', args: []);
  }

  /// `day`
  String get day {
    return Intl.message('day', name: 'day', desc: '', args: []);
  }

  /// `month`
  String get month {
    return Intl.message('month', name: 'month', desc: '', args: []);
  }

  /// `year`
  String get year {
    return Intl.message('year', name: 'year', desc: '', args: []);
  }

  /// `Choose Language`
  String get chooseLanguage {
    return Intl.message(
      'Choose Language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Enter the report reason`
  String get enterTheReportReason {
    return Intl.message(
      'Enter the report reason',
      name: 'enterTheReportReason',
      desc: '',
      args: [],
    );
  }

  /// `Home Screen`
  String get homeScreen {
    return Intl.message('Home Screen', name: 'homeScreen', desc: '', args: []);
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `My Ads`
  String get myAds {
    return Intl.message('My Ads', name: 'myAds', desc: '', args: []);
  }

  /// `Messages`
  String get messages {
    return Intl.message('Messages', name: 'messages', desc: '', args: []);
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `About the Platform`
  String get aboutThePlatform {
    return Intl.message(
      'About the Platform',
      name: 'aboutThePlatform',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Frequently Asked Questions`
  String get frequentlyAskedQuestions {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'frequentlyAskedQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Write your message`
  String get writeYourMessage {
    return Intl.message(
      'Write your message',
      name: 'writeYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `Activated`
  String get activated {
    return Intl.message('Activated', name: 'activated', desc: '', args: []);
  }

  /// `Deactivated`
  String get deactivated {
    return Intl.message('Deactivated', name: 'deactivated', desc: '', args: []);
  }

  /// `Phone number hidden successfully`
  String get phoneNumberHiddenSuccessfully {
    return Intl.message(
      'Phone number hidden successfully',
      name: 'phoneNumberHiddenSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Ad Details`
  String get adDetails {
    return Intl.message('Ad Details', name: 'adDetails', desc: '', args: []);
  }

  /// `Report Ad`
  String get reportAd {
    return Intl.message('Report Ad', name: 'reportAd', desc: '', args: []);
  }

  /// `Advertiser Details`
  String get advertiserDetails {
    return Intl.message(
      'Advertiser Details',
      name: 'advertiserDetails',
      desc: '',
      args: [],
    );
  }

  /// `Edit Ad`
  String get editAd {
    return Intl.message('Edit Ad', name: 'editAd', desc: '', args: []);
  }

  /// `Expired Ad`
  String get expiredAd {
    return Intl.message('Expired Ad', name: 'expiredAd', desc: '', args: []);
  }

  /// `Confirm Action`
  String get confirmAction {
    return Intl.message(
      'Confirm Action',
      name: 'confirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to end this ad?`
  String get areYouSureYouWantToEndThisAd {
    return Intl.message(
      'Are you sure you want to end this ad?',
      name: 'areYouSureYouWantToEndThisAd',
      desc: '',
      args: [],
    );
  }

  /// `Ads`
  String get ads {
    return Intl.message('Ads', name: 'ads', desc: '', args: []);
  }

  /// `Investment Capital`
  String get investmentCapital {
    return Intl.message(
      'Investment Capital',
      name: 'investmentCapital',
      desc: '',
      args: [],
    );
  }

  /// `check out this ad`
  String get checkOutThisAd {
    return Intl.message(
      'check out this ad',
      name: 'checkOutThisAd',
      desc: '',
      args: [],
    );
  }

  /// `Advertiser`
  String get advertiser {
    return Intl.message('Advertiser', name: 'advertiser', desc: '', args: []);
  }

  /// `Contact Number`
  String get contactNumber {
    return Intl.message(
      'Contact Number',
      name: 'contactNumber',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message('Chat', name: 'chat', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Congratulations! Your account has been registered successfully.`
  String get congratulationsYourAccountHasBeenRegisteredSuccessfully {
    return Intl.message(
      'Congratulations! Your account has been registered successfully.',
      name: 'congratulationsYourAccountHasBeenRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully`
  String get accountDeletedSuccessfully {
    return Intl.message(
      'Account deleted successfully',
      name: 'accountDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your profile has been updated successfully.`
  String get congratulationsYourProfileHasBeenUpdatedSuccessfully {
    return Intl.message(
      'Congratulations! Your profile has been updated successfully.',
      name: 'congratulationsYourProfileHasBeenUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your mobile number`
  String get pleaseEnterYourMobileNumber {
    return Intl.message(
      'Please enter your mobile number',
      name: 'pleaseEnterYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Please enter your mobile number and password`
  String get pleaseEnterYourMobileNumberAndPassword {
    return Intl.message(
      'Please enter your mobile number and password',
      name: 'pleaseEnterYourMobileNumberAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Register Now!`
  String get registerNow {
    return Intl.message(
      'Register Now!',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the 4-digit code`
  String get pleaseEnterThe4digitCode {
    return Intl.message(
      'Please enter the 4-digit code',
      name: 'pleaseEnterThe4digitCode',
      desc: '',
      args: [],
    );
  }

  /// `Change Number`
  String get changeNumber {
    return Intl.message(
      'Change Number',
      name: 'changeNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your details`
  String get pleaseEnterYourDetails {
    return Intl.message(
      'Please enter your details',
      name: 'pleaseEnterYourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Platform Idea`
  String get platformIdea {
    return Intl.message(
      'Platform Idea',
      name: 'platformIdea',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Enter Username`
  String get enterUsername {
    return Intl.message(
      'Enter Username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get enterYourEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'enterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Write a message...`
  String get writeAMessage {
    return Intl.message(
      'Write a message...',
      name: 'writeAMessage',
      desc: '',
      args: [],
    );
  }

  /// `Chatting with`
  String get chattingWith {
    return Intl.message(
      'Chatting with',
      name: 'chattingWith',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Read`
  String get read {
    return Intl.message('Read', name: 'read', desc: '', args: []);
  }

  /// `Favorite Ads`
  String get favoriteAds {
    return Intl.message(
      'Favorite Ads',
      name: 'favoriteAds',
      desc: '',
      args: [],
    );
  }

  /// `Report submitted successfully`
  String get reportSubmittedSuccessfully {
    return Intl.message(
      'Report submitted successfully',
      name: 'reportSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Report sent successfully`
  String get reportSentSuccessfully {
    return Intl.message(
      'Report sent successfully',
      name: 'reportSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Investment Sector`
  String get investmentSector {
    return Intl.message(
      'Investment Sector',
      name: 'investmentSector',
      desc: '',
      args: [],
    );
  }

  /// `Average Capital`
  String get averageCapital {
    return Intl.message(
      'Average Capital',
      name: 'averageCapital',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Payment completed successfully.`
  String get congratulationsPaymentCompletedSuccessfully {
    return Intl.message(
      'Congratulations! Payment completed successfully.',
      name: 'congratulationsPaymentCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your ad has been published successfully.`
  String get yourAdHasBeenPublishedSuccessfully {
    return Intl.message(
      'Your ad has been published successfully.',
      name: 'yourAdHasBeenPublishedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Ad deleted successfully.`
  String get adDeletedSuccessfully {
    return Intl.message(
      'Ad deleted successfully.',
      name: 'adDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Ad ended successfully.`
  String get adEndedSuccessfully {
    return Intl.message(
      'Ad ended successfully.',
      name: 'adEndedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your ad edit request has been submitted successfully.`
  String get congratulationsYourAdEditRequestHasBeenSubmittedSuccessfully {
    return Intl.message(
      'Congratulations! Your ad edit request has been submitted successfully.',
      name: 'congratulationsYourAdEditRequestHasBeenSubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your request will be reviewed by the administration, and if approved, the ad will be updated.`
  String get yourRequestWillBeReviewedByTheAdministrationAndIf {
    return Intl.message(
      'Your request will be reviewed by the administration, and if approved, the ad will be updated.',
      name: 'yourRequestWillBeReviewedByTheAdministrationAndIf',
      desc: '',
      args: [],
    );
  }

  /// `Commission Price`
  String get commissionPrice {
    return Intl.message(
      'Commission Price',
      name: 'commissionPrice',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment Method`
  String get selectPaymentMethod {
    return Intl.message(
      'Select Payment Method',
      name: 'selectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Pay Now`
  String get payNow {
    return Intl.message('Pay Now', name: 'payNow', desc: '', args: []);
  }

  /// `Previous`
  String get previous {
    return Intl.message('Previous', name: 'previous', desc: '', args: []);
  }

  /// `Add Your Ad`
  String get addYourAd {
    return Intl.message('Add Your Ad', name: 'addYourAd', desc: '', args: []);
  }

  /// `Please select at least one image`
  String get pleaseSelectAtLeastOneImage {
    return Intl.message(
      'Please select at least one image',
      name: 'pleaseSelectAtLeastOneImage',
      desc: '',
      args: [],
    );
  }

  /// `Ad Images`
  String get adImages {
    return Intl.message('Ad Images', name: 'adImages', desc: '', args: []);
  }

  /// `Write Ad Details`
  String get writeAdDetails {
    return Intl.message(
      'Write Ad Details',
      name: 'writeAdDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter Ad Title`
  String get enterAdTitle {
    return Intl.message(
      'Enter Ad Title',
      name: 'enterAdTitle',
      desc: '',
      args: [],
    );
  }

  /// `Write a Title for the Ad`
  String get writeATitleForTheAd {
    return Intl.message(
      'Write a Title for the Ad',
      name: 'writeATitleForTheAd',
      desc: '',
      args: [],
    );
  }

  /// `Select Main Category`
  String get selectMainCategory {
    return Intl.message(
      'Select Main Category',
      name: 'selectMainCategory',
      desc: '',
      args: [],
    );
  }

  /// `Select Investment Sector`
  String get selectInvestmentSector {
    return Intl.message(
      'Select Investment Sector',
      name: 'selectInvestmentSector',
      desc: '',
      args: [],
    );
  }

  /// `Select Sector`
  String get selectSector {
    return Intl.message(
      'Select Sector',
      name: 'selectSector',
      desc: '',
      args: [],
    );
  }

  /// `Enter Capital`
  String get enterCapital {
    return Intl.message(
      'Enter Capital',
      name: 'enterCapital',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this ad?`
  String get areYouSureYouWantToDeleteThisAd {
    return Intl.message(
      'Are you sure you want to delete this ad?',
      name: 'areYouSureYouWantToDeleteThisAd',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this notification?`
  String get areYouSureYouWantToDeleteThisNotification {
    return Intl.message(
      'Are you sure you want to delete this notification?',
      name: 'areYouSureYouWantToDeleteThisNotification',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `You must enter your name`
  String get youMustEnterYourName {
    return Intl.message(
      'You must enter your name',
      name: 'youMustEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Message Subject`
  String get messageSubject {
    return Intl.message(
      'Message Subject',
      name: 'messageSubject',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Verify Your Mobile Number`
  String get verifyYourMobileNumber {
    return Intl.message(
      'Verify Your Mobile Number',
      name: 'verifyYourMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code sent to`
  String get pleaseEnterTheVerificationCodeSentTo {
    return Intl.message(
      'Please enter the verification code sent to',
      name: 'pleaseEnterTheVerificationCodeSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Edit Your Ad`
  String get editYourAd {
    return Intl.message('Edit Your Ad', name: 'editYourAd', desc: '', args: []);
  }

  /// `Request to Show Number`
  String get requestToShowNumber {
    return Intl.message(
      'Request to Show Number',
      name: 'requestToShowNumber',
      desc: '',
      args: [],
    );
  }

  /// `Request to view this phone number?`
  String get requestToViewThisPhoneNumber {
    return Intl.message(
      'Request to view this phone number?',
      name: 'requestToViewThisPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Project needs capital`
  String get projectNeedsCapital {
    return Intl.message(
      'Project needs capital',
      name: 'projectNeedsCapital',
      desc: '',
      args: [],
    );
  }

  /// `Capital needs an idea`
  String get capitalNeedsAnIdea {
    return Intl.message(
      'Capital needs an idea',
      name: 'capitalNeedsAnIdea',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Search for Opportunity`
  String get searchForOpportunity {
    return Intl.message(
      'Search for Opportunity',
      name: 'searchForOpportunity',
      desc: '',
      args: [],
    );
  }

  /// `Search for Investor`
  String get searchForInvestor {
    return Intl.message(
      'Search for Investor',
      name: 'searchForInvestor',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Chat`
  String get chatnavbar {
    return Intl.message('Chat', name: 'chatnavbar', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Responding to request`
  String get respondingToRequest {
    return Intl.message(
      'Responding to request',
      name: 'respondingToRequest',
      desc: '',
      args: [],
    );
  }

  /// `Response sent successfully`
  String get responseSentSuccessfully {
    return Intl.message(
      'Response sent successfully',
      name: 'responseSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for request approval`
  String get waitingForRequestApproval {
    return Intl.message(
      'Waiting for request approval',
      name: 'waitingForRequestApproval',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message('Clear All', name: 'clearAll', desc: '', args: []);
  }

  /// `Select All`
  String get selectAll {
    return Intl.message('Select All', name: 'selectAll', desc: '', args: []);
  }

  /// `Ad Publishing Fee`
  String get adPublishingFee {
    return Intl.message(
      'Ad Publishing Fee',
      name: 'adPublishingFee',
      desc: '',
      args: [],
    );
  }

  /// `Value Added Tax (15%)`
  String get valueAddedTax15 {
    return Intl.message(
      'Value Added Tax (15%)',
      name: 'valueAddedTax15',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Timeout reached. Closing payment screen`
  String get timeoutReachedClosingPaymentScreen {
    return Intl.message(
      'Timeout reached. Closing payment screen',
      name: 'timeoutReachedClosingPaymentScreen',
      desc: '',
      args: [],
    );
  }

  /// `Payment was not completed, please try again later`
  String get paymentFailedPleaseTryAgainLater {
    return Intl.message(
      'Payment was not completed, please try again later',
      name: 'paymentFailedPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Payment Gateway`
  String get paymentGateway {
    return Intl.message(
      'Payment Gateway',
      name: 'paymentGateway',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get s {
    return Intl.message('s', name: 's', desc: '', args: []);
  }

  /// `All Cities`
  String get allCities {
    return Intl.message('All Cities', name: 'allCities', desc: '', args: []);
  }

  /// `Please specify the sector`
  String get pleaseSpecifyTheSector {
    return Intl.message(
      'Please specify the sector',
      name: 'pleaseSpecifyTheSector',
      desc: '',
      args: [],
    );
  }

  /// `Enter sector name`
  String get enterSectorName {
    return Intl.message(
      'Enter sector name',
      name: 'enterSectorName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter sector name`
  String get pleaseEnterSectorName {
    return Intl.message(
      'Please enter sector name',
      name: 'pleaseEnterSectorName',
      desc: '',
      args: [],
    );
  }

  /// `Demo Version`
  String get demoModeTitle {
    return Intl.message(
      'Demo Version',
      name: 'demoModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment is not available in the demo version.\nThis project is for review and showcase purposes only.`
  String get demoPaymentMessage {
    return Intl.message(
      'Payment is not available in the demo version.\nThis project is for review and showcase purposes only.',
      name: 'demoPaymentMessage',
      desc: '',
      args: [],
    );
  }

  /// `Submitting reports and complaints is not available in the demo version.\nThis project is for review and showcase purposes only.`
  String get demoReportMessage {
    return Intl.message(
      'Submitting reports and complaints is not available in the demo version.\nThis project is for review and showcase purposes only.',
      name: 'demoReportMessage',
      desc: '',
      args: [],
    );
  }

  /// `Sending messages is not available in the demo version.\nThis project is for review and showcase purposes only.`
  String get demoContactUsMessage {
    return Intl.message(
      'Sending messages is not available in the demo version.\nThis project is for review and showcase purposes only.',
      name: 'demoContactUsMessage',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get understood {
    return Intl.message('Got it', name: 'understood', desc: '', args: []);
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
