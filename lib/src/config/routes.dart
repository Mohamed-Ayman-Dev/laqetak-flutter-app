import 'package:flutter/material.dart';
import 'package:invastro/src/features/my_ads/presentation/screens/my_ads_screen.dart';

import '../core/shared/others/presentation/screens/payment_webview.dart';
import '../core/widgets/timeout_splashscreen.dart';
import '../features/ad_details/presentation/screens/ad_details_screen.dart';
import '../features/ad_details/presentation/screens/seller_profile_screen.dart';
import '../features/auth/presentation/screens/auth_screen.dart';
import '../features/auth/presentation/screens/forget_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/auth/presentation/screens/register_password_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/chat/presentation/screens/chat_screen.dart';
import '../features/chat/presentation/screens/conversations_screen.dart';
import '../features/favorite/presentation/screens/favorite_screen.dart';
import '../features/home/presentation/screens/filter_screen.dart';
import '../features/home/presentation/screens/home_layout_screen.dart';
import '../features/my_ads/presentation/screens/add_ad_pay_screen.dart';
import '../features/my_ads/presentation/screens/add_ad_screen.dart';
import '../features/my_ads/presentation/screens/add_ad_second_screen.dart';
import '../features/notifications/presentation/screens/notification_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/static_pages/presentation/screens/about_app_screen.dart';
import '../features/static_pages/presentation/screens/contact_us_screen.dart';
import '../features/static_pages/presentation/screens/questions_screen.dart';

class Routes {
  static const initialRoute = SplashScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    LoginScreen.routeName: (_) => const LoginScreen(),
    AuthScreen.routeName: (_) => const AuthScreen(),
    RegisterPasswordScreen.routeName: (_) => const RegisterPasswordScreen(),
    RegisterScreen.routeName: (_) => const RegisterScreen(),
    OtpScreen.routeName: (_) => const OtpScreen(),
    ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),
    ResetPasswordScreen.routeName: (_) => const ResetPasswordScreen(),
    HomeLayoutScreen.routeName: (_) => const HomeLayoutScreen(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    ChatScreen.routeName: (_) => const ChatScreen(),
    ConversationsScreen.routeName: (_) => const ConversationsScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    FavoriteScreen.routeName: (_) => const FavoriteScreen(),
    MyAdsScreen.routeName: (_) => const MyAdsScreen(),
    AboutAppScreen.routeName: (_) => const AboutAppScreen(),
    ContactUsScreen.routeName: (_) => const ContactUsScreen(),
    PaymentWebView.routeName: (_) => const PaymentWebView(),
    QuestionsScreen.routeName: (_) => const QuestionsScreen(),
    AdDetailsScreen.routeName: (_) => const AdDetailsScreen(),
    SellerProfileScreen.routeName: (_) => const SellerProfileScreen(),
    AddAdScreen.routeName: (_) => const AddAdScreen(),
    AddAdSecondScreen.routeName: (_) => const AddAdSecondScreen(),
    AddAdPayScreen.routeName: (_) => const AddAdPayScreen(),
    FilterScreen.routeName: (_) => const FilterScreen(),
    TimeoutSplashScreen.routeName: (_) => const TimeoutSplashScreen(),
  };
}
