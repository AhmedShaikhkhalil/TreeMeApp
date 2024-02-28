import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color,
    {TextDecoration? decoration}) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: FontConstants.fontFamily,
      color: color,

      // leadingDistribution: TextLeadingDistribution.evn,
      fontWeight: fontWeight,
      decoration: decoration ?? TextDecoration.none);
}

// regular style

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    TextDecoration? decoration}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color,
      decoration: decoration);
}

// medium style

TextStyle getMediumStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    TextDecoration? decoration}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color,
      decoration: decoration);
}

// medium style

TextStyle getLightStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    TextDecoration? decoration}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color,
      decoration: decoration);
}

// bold style

TextStyle getBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    TextDecoration? decoration}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color,
      decoration: decoration);
}

// semibold style

TextStyle getSemiBoldStyle(
    {double fontSize = FontSize.s12,
    required Color color,
    TextDecoration? decoration}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color,
      decoration: decoration);
}
