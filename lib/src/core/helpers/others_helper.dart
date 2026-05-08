import 'package:intl/intl.dart';

import '../di/locator_service.dart';

bool get isArabic => Intl.getCurrentLocale() == 'ar';

bool get isAuth => LocatorService.auth.isAuth;
