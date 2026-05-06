

extension FormatDateTimeOnDateTime on DateTime {
  // // Format time in 12-hour format with AM/PM
  // String formatTime(BuildContext context) {
  //   final isAm = hour < 12;
  //   final period = isAm ? context.translate('am') : context.translate('pm');
  //   final hour12 =
  //       (hour % 12 == 0) ? 12 : hour % 12; // Handle midnight (0) and noon (12)
  //
  //   // Fetch the translated "time_prefix" (e.g., "الساعه" or "o'clock")
  //   final timePrefix = context.translate('time_prefix');
  //
  //   // Format time as "الساعه 12 صباحًا" or "12 o'clock AM"
  //   return '$timePrefix $hour12 $period';
  // }
  //
  // // Format date with month name
  // String formatDate(BuildContext context) {
  //   final monthName = context.translate(
  //     'months_${month - 1}',
  //   ); // Fetch month name from localization
  //   return context.localeCode == 'ar'
  //       ? '$day $monthName $year'
  //       : '$monthName $day, $year';
  // }

  // Calculate remaining time
  Map<String, int> get calculateRemainingTime {
    final now = DateTime.now();
    final difference = this.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  // Format time since
  String since() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative) {
      return 'just now';
    } else if (difference.inSeconds < 60) {
      return '${difference.inSeconds.abs()} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes.abs()} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours.abs()} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays.abs()} days ago';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor().abs()} weeks ago';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor().abs()} months ago';
    } else {
      return '${(difference.inDays / 365).floor().abs()} years ago';
    }
  }
}
