import 'package:flutter/material.dart';

int _screenHeight = 812;
int _screenWidth = 375;

class UtilsReponsive {
  static double _heightPercent(double inputFigmaSize) {
    return (inputFigmaSize / _screenHeight);
  }

  static double _widthPercent(double inputFigmaSize) {
    return (inputFigmaSize / _screenWidth);
  }

  static double height(BuildContext context, double inputFigmaSize) {
    return MediaQuery.of(context).size.height * _heightPercent(inputFigmaSize);
  }

  static double width(BuildContext context, double inputFigmaSize) {
    return MediaQuery.of(context).size.width * _widthPercent(inputFigmaSize);
  }

  static double heightWithStatusBar(
      BuildContext context, double inputFigmaSize) {
    var statusbarHeight = MediaQuery.of(context).viewPadding.top;
    var h = height(context, inputFigmaSize) - statusbarHeight;
    if (h < 0) {
      h = 0;
    }
    return h;
  }

  static EdgeInsets padding(BuildContext context,
      {double horizontal = 16, double vertical = 16}) {
    return EdgeInsets.symmetric(
        horizontal: width(context, horizontal),
        vertical: height(context, vertical));
  }

  static EdgeInsets paddingAll(BuildContext context, {double padding = 16}) {
    return UtilsReponsive.padding(context, horizontal: padding, vertical: padding);
  }

  static EdgeInsets paddingOnly(BuildContext context,
      {double left = 0.0,
      double right = 0.0,
      double top = 0.0,
      double bottom = 0.0}) {
    return EdgeInsets.only(
        left: width(context, left),
        right: width(context, right),
        top: height(context, top),
        bottom: height(context, bottom));
  }

  static EdgeInsets paddingHorizontal(BuildContext context,
      {double padding = 16}) {
    return EdgeInsets.symmetric(horizontal: width(context, padding));
  }

  static EdgeInsets paddingVertical(BuildContext context,
      {double padding = 16}) {
    return EdgeInsets.symmetric(vertical: height(context, padding));
  }

  static Radius radius(BuildContext context, double r) {
    return Radius.circular(width(context, r));
  }

}
