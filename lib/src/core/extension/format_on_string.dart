import 'package:intl/intl.dart';

extension FormatDateOnString on String? {
  get formatTime {
    if (this == null) return '';
    final parsedTime = DateFormat('HH:mm:ss').parse(this ?? '');
    return DateFormat('h:mm a').format(parsedTime);
  }
}
