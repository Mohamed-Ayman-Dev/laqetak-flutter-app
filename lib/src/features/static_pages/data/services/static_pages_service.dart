import 'package:invastro/src/core/network/api_service.dart';

class StaticPagesService {
  Future sendContactUs(
    Map<String, dynamic> data, {
    bool rethrowError = false,
  }) async {
    return await ApiService.post(
      useDefaultUrl: true,
      '/contact-us',
      data: data,
      rethrowError: rethrowError,
    );
  }
}
