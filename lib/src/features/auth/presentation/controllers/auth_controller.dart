

abstract class AuthController {
  /// Login with phone and password
  /// Handles navigation to OTP screen or HomeLayoutScreen based on response
  //   static Future<void> login(
  //     BuildContext context,
  //     Map<String, dynamic> data,
  //   ) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.login(
  //         data,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         // Check if OTP is required (code 007)
  //         if (response['code'] == '007') {
  //           // Navigate to OTP screen for verification
  //           if (!context.mounted) return;
  //           LocatorService.navigationService.currentState?.pushNamed(
  //             OtpScreen.routeName,
  //             arguments: {
  //               'phone': data['phone'],
  //               'from': 'login_screen',
  //               'remainingSeconds': response['data']?['remainingSeconds'] ?? 60,
  //             },
  //           );
  //         } else {
  //           // Login successful - save user data and token
  //           if (!context.mounted) return;
  //           final authProvider = Provider.of<Auth>(context, listen: false);
  //           final userData = response['data'];
  //
  //           // Set token first
  //           if (userData['token'] != null) {
  //             authProvider.setToken(userData['token']);
  //           }
  //
  //           // Set user data and store in preferences
  //           await authProvider.setUser(userData, store: true);
  //
  //           // Navigate to home screen (replace all previous routes)
  //           LocatorService.navigationService.currentState
  //               ?.pushNamedAndRemoveUntil(
  //                 HomeLayoutScreen.routeName,
  //                 (route) => false,
  //               );
  //         }
  //       }
  //     } catch (e) {
  //       if (e is DioException) {
  //         final responseData = e.response?.data;
  //         if (responseData is Map<String, dynamic> &&
  //             responseData.containsKey('code') &&
  //             responseData['code'] == "007" &&
  //             responseData['data']['redirect'] == 'register-otp') {
  //           EasyLoading.showToast(
  //             S.current.pleaseVerifyYourPhoneNumber,
  //             dismissOnTap: true,
  //             toastPosition: EasyLoadingToastPosition.bottom,
  //             duration: const Duration(seconds: 3),
  //           );
  //           LocatorService.navigationService.currentState?.pushNamed(
  //             OtpScreen.routeName,
  //             arguments: {
  //               'phone': data['phone'],
  //               'country_code': data['country_code'],
  //               'from': "login_screen",
  //               'remainingSeconds': responseData['data']['remainingSeconds'],
  //             },
  //           );
  //         } else {
  //           ErrorHelper.handleApiError(e);
  //         }
  //       }
  //     }
  //   }
  //
  //   /// Register a new user
  //   /// Handles navigation to OTP screen on success
  //   static Future<void> register(
  //     BuildContext context,
  //     Map<String, dynamic> data,
  //   ) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.register(
  //         data,
  //         rethrowError: true,
  //         hasMultipartData: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         // Registration successful - navigate to OTP verification
  //         final responseData = response['data'];
  //
  //         if (!context.mounted) return;
  //         LocatorService.navigationService.currentState?.pushNamed(
  //           OtpScreen.routeName,
  //           arguments: {
  //             'from': 'register',
  //             'phone': responseData['phone'] ?? data['phone'],
  //             'customer_id': responseData['customer_id'],
  //             'remainingSeconds': responseData['remainingSeconds'] ?? 120,
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// Verify OTP after registration or login
  //   /// Handles token storage and navigation to success screen or home screen
  //   static Future<void> registerOtp(
  //     BuildContext context,
  //     Map<String, dynamic> data, {
  //     bool isFromLogin = false,
  //   }) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.registerActivateAccount(
  //         data,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         // OTP verified - save user data and token
  //         if (!context.mounted) return;
  //         final authProvider = Provider.of<Auth>(context, listen: false);
  //         final userData = response['data'];
  //
  //         // Set token first
  //         if (userData['token'] != null) {
  //           authProvider.setToken(userData['token']);
  //         }
  //
  //         // Set user data and store in preferences
  //         await authProvider.setUser(userData, store: true);
  //
  //         // Navigate based on source
  //         if (isFromLogin) {
  //           // From login - go to home screen
  //           LocatorService.navigationService.currentState
  //               ?.pushNamedAndRemoveUntil(
  //                 HomeLayoutScreen.routeName,
  //                 (route) => false,
  //               );
  //         } else {
  //           // From registration - go to success screen
  //           LocatorService.navigationService.currentState?.pushNamed(
  //             AuthSuccessScreen.routeName,
  //           );
  //         }
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   static Future<void> checkOtp(
  //     BuildContext context,
  //     Map<String, dynamic> otpData, {
  //     required Map<String, dynamic> data,
  //   }) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.checkOtp(
  //         otpData,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         LocatorService.navigationService.currentState?.popUntil(
  //           (route) => route.settings.name == HomeLayoutScreen.routeName,
  //         );
  //         updateProfile(context, data);
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// Resend OTP for registration
  //   /// Returns Map with remainingSeconds
  //   static Future<Map<String, dynamic>?> registerOtpResend(
  //     Map<String, dynamic> data,
  //   ) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.registerOtpResend(
  //         data,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //       return response;
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //       return null;
  //     }
  //   }
  //
  //   static void resetAccount() {
  //     LocatorService.auth.resetUserForLogOut();
  //     LocatorService.addresses.clearAddressForLogOut();
  //     LocatorService.appSettings.resetAppSettingsForLogOut();
  //     LocatorService.chat.clearMessagesForLogOut();
  //     LocatorService.invoices.clearAllInvoices();
  //     LocatorService.notifications.clearNotificationsForLogOut();
  //     LocatorService.quoteRequests.clearAllOrdersForLogOut();
  //     LocatorService.cars.clearMyCarsForLogOut();
  //     LocatorService.complaints.clearAll();
  //     LocatorService.stores.clearStoresForLogOut();
  //     LocatorService.payments.resetPayments();
  //   }
  //
  //   /// Logout user
  //   /// Clears local storage, resets auth state, and navigates to login
  //   static Future<void> logout({
  //     Map<String, dynamic>? data,
  //     bool sessionExpired = false,
  //   }) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       if (!sessionExpired) {
  //         final deviceToken = await getDeviceToken();
  //
  //         final response = await LocatorService.authService.logout(
  //           // TODO: implement device token
  //           data: {'device_token': deviceToken},
  //           rethrowError: true,
  //         );
  //       }
  //       // Clear local storage
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.remove('token');
  //       await prefs.remove('user');
  //
  //       // Reset Auth provider state
  //       resetAccount();
  //
  //       // Remove token from ApiService headers
  //       ApiService.removeToken();
  //
  //       // Navigate to login screen
  //       LocatorService.navigationService.currentState?.pushNamedAndRemoveUntil(
  //         LoginScreen.routeName,
  //         (route) => false,
  //       );
  //       EasyLoading.dismiss();
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //       return null;
  //     }
  //   }
  //
  //   /// Request password reset OTP
  //   /// Handles navigation to OTP screen on success
  //   static Future<void> forgetPassword(
  //     BuildContext context,
  //     Map<String, dynamic> data, {
  //     bool isRefresh = false,
  //   }) async {
  //     try {
  //       if (!isRefresh) {
  //         EasyLoading.show(status: S.current.pleaseWait);
  //       }
  //       final response = await LocatorService.authService.forgetPassword(
  //         data,
  //         rethrowError: true,
  //       );
  //       if (!isRefresh) {
  //         EasyLoading.dismiss();
  //       }
  //       EasyLoading.showToast(
  //         S.of(context).verificationCodeHasBeenSentToYourPhone,
  //         dismissOnTap: true,
  //         toastPosition: EasyLoadingToastPosition.bottom,
  //         duration: const Duration(seconds: 3),
  //       );
  //       if (!isRefresh && response != null && response['status'] == true) {
  //         // Navigate to OTP screen for password reset verification
  //         if (!context.mounted) return;
  //         LocatorService.navigationService.currentState?.pushNamed(
  //           OtpScreen.routeName,
  //           arguments: {
  //             'phone': data['phone'],
  //             'from': 'forgetPassword',
  //             'remainingSeconds': response['data']?['remainingSeconds'] ?? 120,
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// Verify OTP for password reset
  //   /// Handles navigation to reset password screen on success
  //   static Future<void> forgetPasswordOtp(
  //     BuildContext context,
  //     Map<String, dynamic> data,
  //   ) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.checkForgetPasswordOTP(
  //         data,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         // OTP verified - navigate to reset password screen
  //         if (!context.mounted) return;
  //         LocatorService.navigationService.currentState?.pushNamed(
  //           ResetPasswordScreen.routeName,
  //           arguments: {'phone': data['phone'], 'code': data['code']},
  //         );
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// Reset password after OTP verification
  //   /// Handles navigation to success screen on completion
  //   static Future<void> forgetPasswordReset(
  //     BuildContext context,
  //     Map<String, dynamic> data,
  //   ) async {
  //     try {
  //       EasyLoading.show(status: S.current.pleaseWait);
  //       final response = await LocatorService.authService.changePassword(
  //         data,
  //         rethrowError: true,
  //       );
  //       EasyLoading.dismiss();
  //
  //       if (response != null && response['status'] == true) {
  //         // Password reset successful - navigate to success screen
  //         if (!context.mounted) return;
  //         LocatorService.navigationService.currentState?.pushNamed(
  //           AuthSuccessScreen.routeName,
  //           arguments: {'from': 'resetPassword'},
  //         );
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// Send device token to the server
  //   static Future<void> sendDeviceToken(dynamic token) async {
  //     try {
  //       await LocatorService.authService.sendDeviceToken(
  //         data: {'device_token': token},
  //         rethrowError: true,
  //       );
  //       print('✅ Device token sent to the server successfully');
  //     } catch (e) {
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
  //
  //   /// get device token
  //   static Future<dynamic> getDeviceToken() async {
  //     try {
  //       return await FirebaseMessaging.instance.getToken();
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print(e.toString());
  //       }
  //     }
  //   }
  //
  //   /// get device token
  //   static Future<dynamic> changeLang(String lang) async {
  //     try {
  //       return await LocatorService.authService.changeLang({
  //         'language': lang,
  //       }, rethrowError: true);
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print(e.toString());
  //       }
  //     }
  //   }
  //
  //   /// Try to automatically login user from stored credentials
  //   static Future<bool> tryAutoLogin() async {
  //     try {
  //       final prefs = await SharedPreferences.getInstance();
  //       if (!prefs.containsKey('token') || !prefs.containsKey('user')) {
  //         return false;
  //       }
  //       final token = prefs.getString('token');
  //       final storedUserData = prefs.getString('user');
  //
  //       if (token == null || storedUserData == null || token.isEmpty) {
  //         return false;
  //       }
  //       Map<String, dynamic> userData =
  //           json.decode(storedUserData) as Map<String, dynamic>;
  //       LocatorService.auth.setToken(token);
  //       LocatorService.auth.setUser(userData, notify: true, store: false);
  //       return true;
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print('Auto-login failed: $e');
  //       }
  //       return false;
  //     }
  //   }
  //
  //   /// Get user profile data
  //   /// Returns user data on success
  //   static Future<Map<String, dynamic>?> getProfile() async {
  //     try {
  //       final response = await LocatorService.authService.getProfile(
  //         rethrowError: true,
  //       );
  //       if (response != null && response['status'] == true) {
  //         await LocatorService.auth.setUser(
  //           response['data'] as Map<String, dynamic>,
  //           store: true,
  //         );
  //         return response['data'];
  //       }
  //       return null;
  //     } catch (e) {
  //       ErrorHelper.handleApiError(e);
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //       return null;
  //     }
  //   }
  //
  //   /// Update user profile with automatic photo conversion
  //   /// Handles XFile to MultipartFile conversion and loading states
  //   static Future<void> updateProfile(
  //     BuildContext context,
  //     Map<String, dynamic> data, {
  //     bool hasMultipartData = false,
  //   }) async {
  //     try {
  //       // Show loading
  //       EasyLoading.show(status: S.current.pleaseWait);
  //
  //       // Convert photo from XFile to MultipartFile if needed
  //       if (data['photo'] != null && data['photo'] is! MultipartFile) {
  //         String imagePath;
  //
  //         if (data['photo'] is XFile) {
  //           imagePath = (data['photo'] as XFile).path;
  //         } else if (data['photo'] is String) {
  //           imagePath = data['photo'];
  //         } else {
  //           throw Exception("Invalid photo format");
  //         }
  //
  //         String imageName = imagePath.split('/').last;
  //         data['photo'] = await MultipartFile.fromFile(
  //           imagePath,
  //           filename: imageName,
  //         );
  //         hasMultipartData = true;
  //       }
  //
  //       final response = await LocatorService.authService.editProfile(
  //         data: data,
  //         rethrowError: true,
  //         hasMultipartData: hasMultipartData,
  //       );
  //       EasyLoading.dismiss();
  //       if (response != null &&
  //           response['data']['redirect'] == "update-phone-check-otp") {
  //         LocatorService.navigationService.currentState?.pushNamed(
  //           OtpScreen.routeName,
  //           arguments: {
  //             'phone': data['phone'],
  //             'data': data,
  //             'from': 'updatePhone',
  //             if (response['data'] != null &&
  //                 response['data']['remainingSeconds'] != null)
  //               'remainingSeconds': response['data']['remainingSeconds'],
  //           },
  //         );
  //       } else {
  //         if (response != null && response['status'] == true) {
  //           // Update successful - update local user data
  //           if (!context.mounted) return;
  //           final authProvider = Provider.of<Auth>(context, listen: false);
  //           final userData = response['data'];
  //
  //           // Update user data in provider and store in preferences
  //           await authProvider.setUser(userData, store: true, notify: true);
  //
  //           // Show success message
  //           EasyLoading.showSuccess(
  //             response['message'] ?? S.current.changesHaveBeenSavedSuccessfully,
  //             dismissOnTap: true,
  //           );
  //         }
  //       }
  //     } catch (e) {
  //       EasyLoading.dismiss();
  //       ErrorHelper.handleApiError(e);
  //       if (kDebugMode) {
  //         print(e);
  //       }
  //     }
  //   }
  //
  //   ///get general settings
  //   static Future<void> getGeneralSettings() async {
  //     try {
  //       LocatorService.appSettings.setLoadingSettings(true);
  //
  //       final response = await LocatorService.authService.getSettings(
  //         rethrowError: true,
  //       );
  //       final settings = SettingsModel.fromJson(response['data']);
  //       LocatorService.appSettings.setSettings(settings);
  //
  //       // Save the current stage to SharedPreferences
  //       final prefs = await SharedPreferences.getInstance();
  //       if (settings.currentStage != null) {
  //         await prefs.setString('currentStage', settings.currentStage!);
  //       }
  //     } catch (e) {
  //       ApiService.handleApiError(e);
  //     } finally {
  //       LocatorService.appSettings.setLoadingSettings(false);
  //     }
  //   }
  //
  //   static Future<void> sendBecomeStoreRequest(Map<String, dynamic> data) async {
  //     try {
  //       final Map<String, dynamic> dataToSend = Map<String, dynamic>.from(data);
  //       Future<void> _toFile(String key) async {
  //         if (dataToSend[key] != null &&
  //             dataToSend[key] is String &&
  //             dataToSend[key] is! MultipartFile) {
  //           final path = dataToSend[key] as String;
  //           dataToSend[key] = await MultipartFile.fromFile(
  //             path,
  //             filename: path.split('/').last,
  //           );
  //         }
  //       }
  //
  //       await _toFile('logo');
  //       await _toFile('comm_reg');
  //       await _toFile('terms_and_conditions');
  //       final response = await LocatorService.authService.sendBeSellerRequest(
  //         dataToSend,
  //         onSendProgress: (int sent, int total) {
  //           double progress = sent / total;
  //           if (dataToSend['logo'] != null ||
  //               dataToSend['comm_reg'] != null ||
  //               dataToSend['terms_and_conditions'] != null) {
  //             if ((progress * 100) != 100) {
  //               EasyLoading.showProgress(
  //                 progress,
  //                 status:
  //                     '${(progress * 100).toStringAsFixed(0)}% ${S.current.sendingRequest}',
  //               );
  //             } else if ((progress * 100) == 100) {
  //               EasyLoading.dismiss();
  //               EasyLoading.show(status: S.current.sendingRequest);
  //             }
  //           }
  //         },
  //         rethrowError: true,
  //       );
  //       print(response);
  //       EasyLoading.dismiss();
  //       LocatorService.navigationService.currentState?.pushNamed(
  //         RegisterStoreSuccessScreen.routeName,
  //         arguments: {'ref_number': response['data']['ref_number']},
  //       );
  //     } catch (e) {
  //       ErrorHelper.handleApiError(e);
  //     }
  //   }
}
