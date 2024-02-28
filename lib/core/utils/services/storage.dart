import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class Storage {
  Storage() {
    storage = GetStorage();
  }
  static const String _refreshToken = 'refreshToken';
  static const _jwtToken = 'jwtToken';
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _locale = 'locale';
  static const _fcmToken = 'fcmToken';
  static const _onBoardingVisible = 'onBoardingVisible';
  static const _userType = 'userType';
  static const _phoneNumber = 'phoneNumber';
  static const _firstName = 'firstName';
  static const _lastName = 'lastName';
  static const _userId = 'userId';
  static const _avatar = 'avatar';
  static const _firebaseId = 'firebaseId';
  static const _email = 'email';
  static const _customerId = 'customerId';
  static const _notification = 'notification';

  late GetStorage storage;

  void remove(String key) {
    storage.remove(key);
  }

  void write(String key, dynamic value) {
    storage.write(key, value);
  }

  T? read<T>(String key) {
    return storage.read<T>(key);
  }

  void erase() {
    storage.erase();
  }

  bool get isLoggedIn => storage.read<bool>(_isLoggedIn) ?? false;

  set isLoggedIn(bool newValue) => storage.write(_isLoggedIn, newValue);

  String? get fcmToken => storage.read<String>(_fcmToken);
  set fcmToken(String? newValue) => storage.write(_fcmToken, newValue);

  String? get jwtToken => storage.read<String>(_jwtToken);
  set jwtToken(String? newValue) => storage.write(_jwtToken, newValue);
  String? get firebaseUID => storage.read<String>(_firebaseId);
  set firebaseUID(String? newValue) => storage.write(_firebaseId, newValue);
  String? get locale => storage.read<String>(_locale);
  set locale(String? newValue) => storage.write(_locale, newValue);

  String? get phoneNumber => storage.read<String>(_phoneNumber);
  set phoneNumber(String? newValue) => storage.write(_phoneNumber, newValue);
  String? get refreshToken => storage.read<String>(_refreshToken);
  set refreshToken(String? newValue) => storage.write(_refreshToken, newValue);

  String? get customerId => storage.read<String>(_customerId);
  set customerId(String? newValue) => storage.write(_customerId, newValue);

  String? get fistName => storage.read<String>(_firstName);
  set fistName(String? newValue) => storage.write(_firstName, newValue);

  String? get lastName => storage.read<String>(_lastName);
  set lastName(String? newValue) => storage.write(_lastName, newValue);

  String? get userId => storage.read<String>(_userId);
  set userId(String? newValue) => storage.write(_userId, newValue);
  String? get email => storage.read<String>(_email);
  set email(String? newValue) => storage.write(_email, newValue);
  String? get avatar => storage.read<String>(_avatar);
  set avatar(String? newValue) => storage.write(_avatar, newValue);
  bool get onBoardingVisible => storage.read<bool>(_onBoardingVisible) ?? false;

  set onBoardingVisible(bool newValue) => storage.write(_onBoardingVisible, newValue);
  List<dynamic>? get notification => storage.read<List<dynamic>>(_notification);
  set notification(List<dynamic>? newValue) =>
      storage.write(_notification, jsonEncode(newValue));
}
