import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/shared/models/redirect_model.dart';
import '../../data/models/user_model.dart';

enum AuthMutation {
  none,
  login,
  register,
  registerOtp,
  registerOtpResend,
  sendPhoneOtp,
  logout,
  deleteAccount,
  forgetPassword,
  forgetPasswordOtp,
  resetPassword,
  updateProfile,
}

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.token,
    this.imagePath,
    this.actionStatus = RequestStatus.initial,
    this.lastMutation = AuthMutation.none,
    this.otpResent = false,
    this.otpRedirect,
    this.otpFormData,
    this.otpVerified = false,
    this.successMessage,
    this.verificationErrorMessage,
    this.isNotValid = false,
    this.errorMessage,
  });

  final UserModel? user;
  final String? token;
  final String? imagePath;
  final RequestStatus actionStatus;
  final AuthMutation lastMutation;
  final bool otpResent;
  final RedirectModel? otpRedirect;
  final Map<String, dynamic>? otpFormData;
  final bool otpVerified;
  final String? successMessage;
  final String? verificationErrorMessage;
  final bool isNotValid;
  final String? errorMessage;

  bool get isAuth => user != null && token != null;

  AuthState copyWith({
    UserModel? user,
    String? token,
    String? imagePath,
    RequestStatus? actionStatus,
    AuthMutation? lastMutation,
    bool? otpResent,
    RedirectModel? otpRedirect,
    Map<String, dynamic>? otpFormData,
    bool? otpVerified,
    String? successMessage,
    String? verificationErrorMessage,
    bool? isNotValid,
    String? errorMessage,
    bool clearUser = false,
    bool clearImagePath = false,
    bool clearOtp = false,
    bool clearVerification = false,
    bool clearSuccessMessage = false,
  }) => AuthState(
    user: clearUser ? null : (user ?? this.user),
    token: clearUser ? null : (token ?? this.token),
    imagePath: clearImagePath ? null : (imagePath ?? this.imagePath),
    actionStatus: actionStatus ?? this.actionStatus,
    lastMutation: lastMutation ?? this.lastMutation,
    otpResent: otpResent ?? this.otpResent,
    otpRedirect: clearOtp ? null : (otpRedirect ?? this.otpRedirect),
    otpFormData: clearOtp ? null : (otpFormData ?? this.otpFormData),
    otpVerified: otpVerified ?? this.otpVerified,
    successMessage: clearSuccessMessage
        ? null
        : (successMessage ?? this.successMessage),
    verificationErrorMessage: clearVerification
        ? null
        : (verificationErrorMessage ?? this.verificationErrorMessage),
    isNotValid: clearVerification ? false : (isNotValid ?? this.isNotValid),
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    user,
    token,
    imagePath,
    actionStatus,
    lastMutation,
    otpResent,
    otpRedirect,
    otpFormData,
    otpVerified,
    successMessage,
    verificationErrorMessage,
    isNotValid,
    errorMessage,
  ];
}
