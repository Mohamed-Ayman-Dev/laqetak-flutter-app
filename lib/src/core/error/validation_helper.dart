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

  static validatePasswordConfirmation(
    String? value,
    String password,
    BuildContext context,
  ) {
    if (value != password) {
      return S.of(context).passwordsDoNotMatch;
    }
    return validateEmpty(
      value,
      emptyMessage: S.of(context).pleaseEnterAPasswordConfirmation,
    );
    // var validator = Validator(
    //   validators: [
    //     const RequiredValidator(),
    //     const MinLengthValidator(length: 6)
    //   ],
    // );
    // return validator.validate(
    //   label: S.of(context).password,
    //   value: value,
    // );
  }

  static validateIbanConfirmation(
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
  // static String? validateSaudiPhoneOrEmail(
  //     String? value,
  //     BuildContext context,
  //     ) {
  //   // 1) empty
  //   if (value == null || value.trim().isEmpty) {
  //     // يفضل تضيف سترينج جديد في الـ S مثلاً:
  //     // pleaseEnterPhoneOrEmail
  //     return 'Please enter phone or email ';
  //   }
  //
  //   final input = value.trim();
  //
  //   // 2) جرّب أولاً بنفس طريقة validatePhone (سعودي)
  //   //    لو رجعت null يبقى رقم صحيح
  //   if (validatePhone(input, context) == null) {
  //     return null;
  //   }
  //
  //   // 3) لو مش رقم سعودي صحيح، جرّب الإيميل بنفس validateEmail
  //   final emailError = validateEmail(
  //     input,
  //     // مش هنستخدم رسائل الإيميل هنا لأننا أصلاً اتأكدنا إنه مش فاضي
  //     emptyMessage: '',
  //     invalidMessage: '',
  //   );
  //
  //   if (emailError == null) {
  //     // الإيميل valid
  //     return null;
  //   }
  //
  //   // 4) لا هو موبايل سعودي صحيح ولا إيميل صحيح
  //   // أضف سترينج جديد في S مثلاً:
  //   // pleaseEnterAValidPhoneOrEmail
  //   return S.of(context).pleaseEnterAValidPhoneOrEmail;
  // }

  //
  // static String? validateEmail(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return S
  //         .of(context)
  //         .emailCannotBeEmpty; // Arabic: الايميل لا يمكن أن يكون فارغاً
  //   } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
  //       .hasMatch(value)) {
  //     return S.of(context).pleaseEnterAValidEmail; // Arabic: الايميل غير صحيح
  //   } else if (!isValidDomain(value)) {
  //     return S
  //         .of(context)
  //         .pleaseEnterAValidEmail; // Arabic: يجب أن يكون الايميل من نطاق صحيح (مثل Gmail أو Yahoo)
  //   }
  //   return null; // No errors
  // }

  // // Adjusted method to check if the domain is valid
  //   static bool isValidDomain(String email) {
  //     // List of valid domains
  //     List<String> validDomains = [
  //       'gmail',
  //       'yahoo',
  //       'outlook',
  //       'hotmail',
  //       'icloud',
  //       // Add more real domains as needed
  //     ];
  //
  //     String domain = email.split('@').last.toLowerCase();
  //
  //     // Check if the domain or any subdomain is in the list of valid domains
  //     return validDomains.any((validDomain) => domain.contains(validDomain));
  //   }

  // Method to validate English names
  // static String? validateEnglishName(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return S
  //         .of(context)
  //         .nameCannotBeEmpty; // Arabic: الاسم لا يمكن أن يكون فارغاً
  //   } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
  //     return S
  //         .of(context)
  //         .pleaseEnterAnEnglishName; // Arabic: يرجى إدخال اسم باللغة الإنجليزية
  //   }
  //   return null; // No errors
  // }

  // // Method to validate Arabic names
  // static String? validateArabicName(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return S
  //         .of(context)
  //         .nameCannotBeEmpty; // Arabic: الاسم لا يمكن أن يكون فارغاً
  //   } else if (!RegExp(r'^[\u0621-\u064A\s]+$').hasMatch(value)) {
  //     return S
  //         .of(context)
  //         .pleaseEnterAnArabicName; // Arabic: يرجى إدخال اسم باللغة العربية
  //   }
  //   return null; // No errors
  // }

  // // New method to validate exactly 8 digits and check if it's not empty
  // static String? validateTenDigits(String? value, BuildContext context) {
  //   if (value == null || value.isEmpty) {
  //     return S
  //         .of(context)
  //         .fieldCannotBeEmpty; // Example: الحقل لا يمكن أن يكون فارغاً
  //   } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
  //     return S
  //         .of(context)
  //         .fieldShouldBeExactly10Digits; // Example: يجب أن يحتوي الحقل على 10 أرقام
  //   }
  //   return null; // No errors
  // }

  // // New method to validate exactly 8 digits and check if it's not empty
  //   static String? validateDigits(String? value, BuildContext context) {
  //     if (value == null || value.isEmpty) {
  //       return S
  //           .of(context)
  //           .fieldCannotBeEmpty; // Example: الحقل لا يمكن أن يكون فارغاً
  //     } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
  //       return S
  //           .of(context)
  //           .fieldShouldBeExactly10Digits; // Example: يجب أن يحتوي الحقل على 10 أرقام
  //     }
  //     return null; // No errors
  //   }
}
