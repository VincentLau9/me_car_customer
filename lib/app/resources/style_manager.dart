import 'package:flutter/material.dart';
import 'package:me_car_customer/app/resources/font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getRegularStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.regular, color);
}

TextStyle getLightStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.light, color);
}
TextStyle getBoldStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.bold, color);
}
TextStyle getBlackStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.black, color);
}
TextStyle getMediumStyle(
    {double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.medium, color);
}
TextStyle getLargeStyle(
    {double fontSize = FontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, FontsConstant.fontFamily, FontWeightManager.bold, color);
}