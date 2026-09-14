import '../../../../core/shared/models/redirect_model.dart';

class AdOtpResult {
  const AdOtpResult({this.message, this.redirect});

  final String? message;
  final RedirectModel? redirect;
}
