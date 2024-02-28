import 'package:flutter/cupertino.dart';

class ColorManager {
  static const Color mainColor = Color(0xff46D1F7);
  static const Color gradiantSplash = Color(0xffBAECFB);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color borderCircle = Color(0xFFD9D9D9);
  static const Color background = Color(0xffECECEC);
  static const Color shadowlogo = Color(0xff4DBDDC);
  static const Color hintColor = Color(0x80000000);
  static const Color shadowButton = Color(0x544ed2f7);
  static const Color textFontColor = Color(0xff2F394B);
  static const Color textFont1Color = Color(0xff8F959F);
  static const Color authBackGround = Color(0xffE5E5E5);
  static const Color unselectedIconColor = Color(0xff898989);
  static const Color iconColor = Color(0xff848484);
  static const Color dividerGrey = Color(0xffB5B5B5);
  static const Color dividerGrey1 = Color(0xffBCBCBC);
  static const Color authText = Color(0xffFEAA46);
  static const Color outerCircle = Color(0xffCBCBCB);
  static const Color goodMorning = Color(0xff464455);
  static const Color chatBackGround = Color(0xffF7F7F7);
  static const Color inactiveIcon = Color(0xffD8E6FD);
  static const Color activeIcon = Color(0xffFEAA46);
  static const Color subTitleCreateEvent = Color(0xff8D96A5);
  static const Color moveColor = Color.fromRGBO(234, 68, 60, 1.0);

  LinearGradient gradient1 = const LinearGradient(
      colors: [mainColor, gradiantSplash],
      tileMode: TileMode.decal,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  LinearGradient gradientButton = const LinearGradient(
      colors: [mainColor, gradiantSplash],
      tileMode: TileMode.clamp,
      begin: Alignment.bottomRight,
      stops: [0.0, 1.5],
      end: Alignment.topLeft);

  LinearGradient gradientFloating = LinearGradient(
      colors: [Color(0xffBAECFB), Color(0xff46D1F7)],
      tileMode: TileMode.decal,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
