import 'package:intl/intl.dart';

import '../constants/string_manager.dart';
import '../di/locator_service.dart';

bool get isArabic => Intl.getCurrentLocale() == StringManager.arLanguageCode;

bool get isAuth => LocatorService.auth.isAuth;
