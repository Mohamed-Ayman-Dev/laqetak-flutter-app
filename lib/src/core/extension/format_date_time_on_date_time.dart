import '../../../generated/l10n.dart';

extension FormatDateTimeOnDateTime on DateTime {
  String get timeAgo {
    final diff = DateTime.now().difference(this);

    if (diff.inSeconds < 5) {
      return S.current.now;
    }

    if (diff.inSeconds < 60) {
      return '${diff.inSeconds} ${S.current.second}';
    }

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} ${S.current.minute}';
    }

    if (diff.inHours < 24) {
      return '${diff.inHours} ${S.current.hour}';
    }

    if (diff.inDays < 30) {
      return '${diff.inDays} ${S.current.day}';
    }

    if (diff.inDays < 365) {
      return '${(diff.inDays / 30).floor()} ${S.current.month}';
    }

    return '${(diff.inDays / 365).floor()} ${S.current.year}';
  }
}
