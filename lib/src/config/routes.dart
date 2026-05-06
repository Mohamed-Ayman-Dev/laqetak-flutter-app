import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../core/dependency_injection/locator.dart' as di;
import '../core/error/no_internet_connection_page.dart';

class Routes {
  static const initialRoute = SplashScreen.routeName;

  static final Map<String, WidgetBuilder> routes = {
    SplashScreen.routeName: (_) => const SplashScreen(),
    // LoginScreen.routeName: (_) => const LoginScreen(),
    // HomeLayoutScreen.routeName: (_) => const HomeLayoutScreen(),
    // WelcomeScreen.routeName: (_) => const WelcomeScreen(),
    // OnboardingScreen.routeName: (_) => const OnboardingScreen(),
    // ForgetPasswordScreen.routeName: (_) => const ForgetPasswordScreen(),
    // OtpScreen.routeName: (_) => const OtpScreen(),
    // RegisterScreen.routeName: (_) => const RegisterScreen(),
    // RegisterPasswordScreen.routeName: (_) => const RegisterPasswordScreen(),
    // AuthSuccessScreen.routeName: (_) => const AuthSuccessScreen(),
    // ResetPasswordScreen.routeName: (_) => const ResetPasswordScreen(),
    // StoreDetailsScreen.routeName: (_) => const StoreDetailsScreen(),
    // RequestProductScreen.routeName: (_) => const RequestProductScreen(),
    // NotificationScreen.routeName: (_) => const NotificationScreen(),
    // OrdersOffersScreen.routeName: (_) => const OrdersOffersScreen(),
    // OrderDetailsScreen.routeName: (_) => const OrderDetailsScreen(),
    // ChatScreen.routeName: (_) => const ChatScreen(),
    // PaymentMethodsScreen.routeName: (_) => const PaymentMethodsScreen(),
    // RegisterStoreScreen.routeName: (_) => const RegisterStoreScreen(),
    // SearchScreen.routeName: (_) => const SearchScreen(),
    // TermsScreen.routeName: (_) => const TermsScreen(),
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
    InternetConnection.routeName: (_) =>
        InternetConnection(internetConnectionChecker: di.sl()),
  };
}
