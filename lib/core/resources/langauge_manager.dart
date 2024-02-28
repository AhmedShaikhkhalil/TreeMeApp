import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC, HEBREW }

const String ARABIC = "ar";
const String ENGLISH = "en";
const String HEBREW = 'he';
const String ASSET_PATH_LOCALISATIONS = "assets/translations";

const Locale ARABIC_LOCAL = Locale("ar", "SA");
const Locale ENGLISH_LOCAL = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
      case LanguageType.HEBREW:
        return HEBREW;
    }
  }
}
