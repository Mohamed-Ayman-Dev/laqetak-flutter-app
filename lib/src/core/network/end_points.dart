final class EndPoints {
  EndPoints._();

  /// Base URLs
  static const String baseUrl = "https://ghiar-tech.dev4.wady.sa/api/v1";
  static const String userBaseUrl =
      'https://ghiar-tech.dev4.wady.sa/api/v1/customer';

  /// Auth
  static const String refreshToken = "/refresh-token";
  static const String register = "/register";
  static const String login = "/login";
  static const String logout = "/logout";

  /// Addresses
  static const String getAddresses = "/addresses/list";
  static const String addAddresses = "/addresses/add";
  static const String editAddresses = "/addresses/update";
  static const String selectDefaultAddresses = "/addresses/set-default";
  static const String deleteAddress = "/addresses/delete";
  static const String getCites = "$baseUrl/cities";
  static const String getRegions = "$baseUrl/regions";

  // static const String baseUrl = String.fromEnvironment('LOGOUT');
}
