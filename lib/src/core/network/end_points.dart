final class EndPoints {
  EndPoints._();

  /// Base URLs
  static const String baseUrl = "https://invastro.dev4.wady.sa/api/v1";
  static const String userBaseUrl =
      'https://invastro.dev4.wady.sa/api/v1/customer';

  /// Auth (customer)
  static const String login = "$userBaseUrl/login";
  static const String register = "$userBaseUrl/register";
  static const String logout = "$userBaseUrl/logout";
  static const String registerOtp = "$userBaseUrl/register-otp";
  static const String registerOtpResend = "$userBaseUrl/register-otp-resend";
  static const String forgetPassword = "$userBaseUrl/forgetpassword";
  static const String forgetPasswordOtp = "$userBaseUrl/forgetpassword-otp";
  static const String forgetPasswordReset = "$userBaseUrl/forgetpassword-reset";
  static const String getProfile = "$userBaseUrl/profile/info";
  static const String updateProfile = "$userBaseUrl/profile/update";
  static const String deleteProfile = "$userBaseUrl/profile/delete";
  static const String profilePhoneOtp = "$userBaseUrl/profile/phone-otp";
  static const String updateLanguage = "$userBaseUrl/profile/update-language";
  static const String deviceToken = "$userBaseUrl/profile/device-token";

  /// Addresses
  static const String getAddresses = "/addresses/list";
  static const String addAddresses = "/addresses/add";
  static const String editAddresses = "/addresses/update";
  static const String selectDefaultAddresses = "/addresses/set-default";
  static const String deleteAddress = "/addresses/delete";

  /// Others
  static const String getSettings = "$baseUrl/settings";
  static const String getCategories = "$baseUrl/categories";
  static const String getCities = "$baseUrl/cities";
  static const String getBudgetRanges = "$baseUrl/budget-ranges";
  static const String getSectors = "$baseUrl/sectors";

  /// Static pages
  static const String getFaqs = "$baseUrl/faqs";
  static const String contactUs = "$baseUrl/contact-us";

  /// Notifications (customer)
  static const String getNotifications = "$userBaseUrl/notifications/list";
  static const String markNotificationsRead =
      "$userBaseUrl/notifications/read-all";
  static String deleteNotification(num id) =>
      "$userBaseUrl/notifications/delete/$id";
  static const String respondContactRequest =
      "$userBaseUrl/ads/contact-request/respond";

  /// Ads (customer)
  static const String getAds = "$userBaseUrl/ads/list";
  static String getAdDetails(num id) => "$userBaseUrl/ads/detail/$id";
  static const String getFavAds = "$userBaseUrl/favorites/list";
  static const String toggleFav = "$userBaseUrl/favorites/toggle";
  static const String sendAdComplaint = "$userBaseUrl/ads/complaint";
  static const String sendCustomerComplaint =
      "$userBaseUrl/advertisor/complaint";
  static String getCustomerAds(num id) => "$userBaseUrl/advertisor/ads/$id";
  static String toggleHidePhone(num id) =>
      "$userBaseUrl/my-ads/toggle-contact-phone/$id";
  static const String requestContact = "$userBaseUrl/ads/request-contact";

  /// My ads (customer)
  static const String getMyAds = "$userBaseUrl/my-ads/list";
  static const String createMyAd = "$userBaseUrl/my-ads/create";
  static const String updateMyAd = "$userBaseUrl/my-ads/update";
  static const String sendAdOtp = "$userBaseUrl/my-ads/contact-phone-otp";
  static const String payMyAd = "$userBaseUrl/my-ads/pay";
  static String deleteMyAd(num id) => "$userBaseUrl/my-ads/delete/$id";
  static String closeMyAd(num id) => "$userBaseUrl/my-ads/close-ad/$id";

  /// Chat (customer)
  static const String getConversations = "$userBaseUrl/conversations/list";
  static String getChatMessages(num id) => "$userBaseUrl/messages/list/$id";
  static const String sendChatMessage = "$userBaseUrl/messages/send";
  static const String chatPresenceHeartbeat =
      "$userBaseUrl/conversations/presence/heartbeat";
  static const String chatPresenceLeave =
      "$userBaseUrl/conversations/presence/leave";
  static const String markConversationRead =
      "$userBaseUrl/conversations/mark-as-read";
  static const String openConversation = "$userBaseUrl/conversations/open";
  static const String pusherAuth =
      "http://invastro.dev4.wady.sa/broadcasting/auth";

  // static const String baseUrl = String.fromEnvironment('LOGOUT');
}
