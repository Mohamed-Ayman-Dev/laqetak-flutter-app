import 'package:flutter/material.dart';

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
import '../features/home/presentation/screens/home_layout_screen.dart';
import '../features/notifications/presentation/screens/notifications_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/static_pages/presentation/screens/terms_screen.dart';

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
    TermsScreen.routeName: (_) => const TermsScreen(),
    NotificationsScreen.routeName: (_) => const NotificationsScreen(),
    ChatScreen.routeName: (_) => const ChatScreen(),
    ConversationsScreen.routeName: (_) => const ConversationsScreen(),
    ProfileScreen.routeName: (_) => const ProfileScreen(),
    FavoriteScreen.routeName: (_) => const FavoriteScreen(),

    // OnboardingScreen.routeName: (_) => const OnboardingScreen(),
    // AuthSuccessScreen.routeName: (_) => const AuthSuccessScreen(),
    // StoreDetailsScreen.routeName: (_) => const StoreDetailsScreen(),
    // RequestProductScreen.routeName: (_) => const RequestProductScreen(),
    // OrdersOffersScreen.routeName: (_) => const OrdersOffersScreen(),
    // OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
    // ChatScreen.routeName: (_) => const ChatScreen(),
    // PaymentMethodsScreen.routeName: (_) => const PaymentMethodsScreen(),
    // RegisterStoreScreen.routeName: (_) => const RegisterStoreScreen(),
    // SearchScreen.routeName: (_) => const SearchScreen(),
    // AboutAppScreen.routeName: (_) => const AboutAppScreen(),
    // QuestionsScreen.routeName: (_) => const QuestionsScreen(),
    // ContactUsScreen.routeName: (_) => const ContactUsScreen(),
    // InvoicesScreen.routeName: (_) => const InvoicesScreen(),
    // FavScreen.routeName: (_) => const FavScreen(),
    // AddressesScreen.routeName: (_) => const AddressesScreen(),
    // PDFViewerScreen.routeName: (_) => const PDFViewerScreen(),
    // OrdersScreen.routeName: (_) => const OrdersScreen(),
    // ComplaintsScreen.routeName: (_) => const ComplaintsScreen(),
    // CarsScreen.routeName: (_) => const CarsScreen(),
    // MapScreen.routeName: (_) => const MapScreen(),
    // RegisterStoreSuccessScreen.routeName: (_) =>
    //     const RegisterStoreSuccessScreen(),
  };
}
