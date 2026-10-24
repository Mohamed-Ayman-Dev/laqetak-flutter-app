import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  static Future<void> openEmailSmart({
    required String emailAddress,
    String subject = '',
    String body = '',
  }) async {
    final String encodedSubject = Uri.encodeComponent(subject);
    final String encodedBody = Uri.encodeComponent(body);

    // 1️⃣ Gmail App Intent URL (Android only)
    final Uri gmailUri = Uri.parse(
      'googlegmail://co?to=$emailAddress&subject=$encodedSubject&body=$encodedBody',
    );

    // 2️⃣ Standard mailto: (for generic email apps)
    final Uri mailtoUri = Uri.parse(
      'mailto:$emailAddress?subject=$encodedSubject&body=$encodedBody',
    );

    // 3️⃣ Gmail web fallback (works everywhere)
    final Uri gmailWebUrl = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=$emailAddress'
      '&su=$encodedSubject&body=$encodedBody',
    );

    try {
      // Try Gmail app first
      if (await canLaunchUrl(gmailUri)) {
        await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
        return;
      }

      // Try generic mailto
      if (await canLaunchUrl(mailtoUri)) {
        await launchUrl(mailtoUri, mode: LaunchMode.externalApplication);
        return;
      }

      // Fallback to Gmail Web
      await launchUrl(gmailWebUrl, mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      EasyLoading.showToast(
        'Could not open email: $e',
        duration: const Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    }
  }

  static Future<void> launchSocialLink(String url) async {
    final Uri uri = Uri.parse(url);

    // Check if the device can handle the URL
    if (await canLaunchUrl(uri)) {
      try {
        // Launch the URL
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        // Handle the error if the URL can't be launched
        print('Could not launch $url: $e');
      }
    } else {
      // If the app is not installed or cannot launch, fallback to browser
      throw 'Could not launch $url';
    }
  }

  static Future<void> openWhatsApp(
    String phoneNumber, {
    String message = '',
  }) async {
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUri = Uri.parse(
      "whatsapp://send?phone=$phoneNumber&text=$encodedMessage",
    );
    final whatsappBusinessUri = Uri.parse(
      "whatsapp://send?phone=$phoneNumber&text=$encodedMessage",
    ); // same URI scheme
    final fallbackUrl = Uri.parse(
      "https://wa.me/$phoneNumber?text=$encodedMessage",
    );
    try {
      if (await canLaunchUrl(whatsappUri)) {
        // Open WhatsApp (normal)
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(whatsappBusinessUri)) {
        // Open WhatsApp Business
        await launchUrl(
          whatsappBusinessUri,
          mode: LaunchMode.externalApplication,
        );
      } else if (await canLaunchUrl(fallbackUrl)) {
        // Fallback to web
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        // Could not open any
        EasyLoading.showToast(
          'WhatsApp is not installed or cannot open on this device',
          dismissOnTap: true,
          duration: const Duration(seconds: 3),
          toastPosition: EasyLoadingToastPosition.bottom,
        );
      }
    } catch (e) {
      EasyLoading.showToast(
        'Error opening WhatsApp: $e',
        dismissOnTap: true,
        duration: const Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
      );
    }
  }

  static Future<void> openDialer(String phoneNumber) async {
    // Add the +966 prefix
    final Uri telUrl = Uri(scheme: 'tel', path: '+966$phoneNumber');

    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl);
    } else {
      EasyLoading.showToast(
        'Could not launch $telUrl',
        dismissOnTap: true,
        duration: const Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom,
      );
      throw 'Could not launch $telUrl';
    }
  }

}
