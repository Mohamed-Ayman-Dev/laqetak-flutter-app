import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

class ValidationHelper {
  static String? validateEmpty(dynamic value, {required String emptyMessage}) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    return null;
  }

  static String? validateName(
    String? value, {
    required String emptyMessage,
    required String invalidMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    if (!RegExp(r"^[a-zA-Z\u0621-\u064A\s'-]+$").hasMatch(value)) {
      return invalidMessage;
    }
    return null;
  }

  static String? validateUsername(
    String? value, {
    required String emptyMessage,
    required String invalidMessage,
    int minLength = 3,
    int maxLength = 30,
  }) {
    if (value == null || value.trim().isEmpty) {
      return emptyMessage;
    }

    final trimmed = value.trim();

    if (trimmed.length < minLength || trimmed.length > maxLength) {
      return invalidMessage;
    }

    // حروف إنجليش + أرقام + _ و . و -
    if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(trimmed)) {
      return invalidMessage;
    }

    return null;
  }

  static String? validateEmail(
    String? value, {
    required String emptyMessage,
    required String invalidMessage,
  }) {
    if (value == null || value.isEmpty) {
      return emptyMessage;
    }
    if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(value)) {
      return invalidMessage;
    }
    return null;
  }

  static String? validatePhone(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S.of(context).pleaseEnterAPhoneNumber;
    } else if (!RegExp(r'^0?5\d{8}$').hasMatch(value)) {
      // Allow optional leading 0
      if (value.length < 9 || value.length > 10) {
        // 10 with leading 0, 9 without
        return S.of(context).phoneNumberShouldBeAtLeast9Characters;
      } else {
        return S.of(context).pleaseEnterAValidPhoneNumber;
      }
    }
    return null; // No errors
  }

  static String? validatePhoneByCountryCode({
    required String? phone,
    required String countryCode,
    required BuildContext context,
  }) {
    if (phone == null || phone.isEmpty) {
      return S.of(context).pleaseEnterAPhoneNumber;
    }

    final trimmed = phone.replaceAll(RegExp(r'\s+'), '');

    // Remove leading 0 if present
    final normalized = trimmed.startsWith('0') ? trimmed.substring(1) : trimmed;

    // Define patterns by country code (for normalized numbers)
    final patterns = {
      '+966': RegExp(r'^5\d{8}$'), // Saudi (5xxxxxxxx)
      '+20': RegExp(r'^1[0125]\d{8}$'), // Egypt (1xxxxxxxxx)
      // Add more as needed
    };

    final pattern = patterns[countryCode];

    if (pattern == null) {
      // No pattern for this country, optionally skip validation or return generic error
      return null;
    }

    if (!pattern.hasMatch(normalized)) {
      return S.of(context).pleaseEnterAValidPhoneNumber;
    }

    return null; // Valid
  }

  static String? validatePassword(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return S
          .of(context)
          .passwordCannotBeEmpty; // Arabic: الباسورد لا يمكن أن يكون فارغاً
    } else if (value.length < 8) {
      return S
          .of(context)
          .passwordShouldBeAtLeast8Characters; // Arabic: يجب أن لا يقل الباسورد عن 8 أحرف أو أرقام
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return S
          .of(context)
          .passwordShouldContainOnlyEnglishLettersAndNumbers; // Arabic: يجب أن يحتوي الباسورد على أحرف وأرقام إنجليزية فقط
    }
    return null; // No errors
  }

  static String? validatePasswordConfirmation(
    String? value,
    String password,
    BuildContext context, {
    bool validateEmptyEnabled = true,
  }) {
    if (value != password) {
      return S.of(context).passwordsDoNotMatch;
    }
    if (validateEmptyEnabled) {
      return validateEmpty(
        value,
        emptyMessage: S.of(context).pleaseEnterAPasswordConfirmation,
      );
    }
    return null;
  }

  static String? validateIbanConfirmation(
    String? value,
    String iban,
    BuildContext context,
  ) {
    if (value != iban) {
      return S.of(context).ibanDoNotMatch;
    }
    return validateEmpty(
      value,
      emptyMessage: S.of(context).pleaseEnterIbanConfirmation,
    );
  }
}
