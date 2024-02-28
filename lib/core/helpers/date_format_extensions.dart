import 'package:intl/intl.dart' as intl;

extension DateFromattoString on DateTime {
  String formatToString() {
    return intl.DateFormat(
      'yyyy-MM-dd',
    ).format(this).toString();
  }
}

extension DateFormatTimeToString on DateTime {
  String formatDateToString() {
    return intl.DateFormat(
      'h:mm a',
    ).format(this).toString().toLowerCase();
  }
}

extension DateFormatNotificationTimeToString on DateTime {
  String formatDateToString() {
    return intl.DateFormat(
      'yyyy-MM-dd h:mm a ',
    ).format(this).toString().toLowerCase();
  }
}
