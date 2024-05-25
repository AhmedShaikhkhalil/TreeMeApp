import 'dart:ui';

import 'package:treeme/core/utils/services/storage.dart';

class AppConfig {
  static String? firstName = Storage().fistName;
  static String? phoneNumber = Storage().phoneNumber;
  static String? userId = Storage().userId;
  static String? avatar = Storage().avatar;
  static String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}

enum RequestStatus { LOADING, SUCESS, ERROR }

enum CreateVideoStatus { LOADING, SUCESS, ERROR, INITIAL }

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final StringBuffer buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
