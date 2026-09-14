import '../../../../core/shared/models/redirect_model.dart';

class PhoneOtpResult {
  const PhoneOtpResult({this.redirect, this.message});

  final RedirectModel? redirect;
  final String? message;
}
