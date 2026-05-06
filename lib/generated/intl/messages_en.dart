// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancellationReasonIsRequired": MessageLookupByLibrary.simpleMessage(
      "Cancellation reason is required",
    ),
    "connectionErrorPleaseCheckYourInternetConnection":
        MessageLookupByLibrary.simpleMessage(
          "Connection Error Please Check Your Internet Connection",
        ),
    "ibanDoNotMatch": MessageLookupByLibrary.simpleMessage("Iban do not match"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "passwordCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Password cannot be empty",
    ),
    "passwordShouldBeAtLeast8Characters": MessageLookupByLibrary.simpleMessage(
      "Password should be at least 8 characters",
    ),
    "passwordShouldContainOnlyEnglishLettersAndNumbers":
        MessageLookupByLibrary.simpleMessage(
          "Password should contain only English letters and numbers",
        ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "phoneNumberShouldBeAtLeast9Characters":
        MessageLookupByLibrary.simpleMessage(
          "Phone number should be at least 9 characters",
        ),
    "pleaseEnterAPasswordConfirmation": MessageLookupByLibrary.simpleMessage(
      "Please enter a password confirmation",
    ),
    "pleaseEnterAPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter a phone number",
    ),
    "pleaseEnterAValidPhoneNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid phone number",
    ),
    "pleaseEnterIbanConfirmation": MessageLookupByLibrary.simpleMessage(
      "Please enter iban confirmation",
    ),
    "pleaseEnterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Please enter verification code",
    ),
    "pleaseWait": MessageLookupByLibrary.simpleMessage("Please Wait..."),
    "sessionExpiredPleaseLoginAgain": MessageLookupByLibrary.simpleMessage(
      "Session Expired Please Login Again",
    ),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "usernameOrPasswordIsIncorrect": MessageLookupByLibrary.simpleMessage(
      "Username Or Password Is Incorrect",
    ),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "writeTheReason": MessageLookupByLibrary.simpleMessage("Write the reason"),
    "youLoggedInSuccessfully": MessageLookupByLibrary.simpleMessage(
      "You logged in successfully",
    ),
  };
}
