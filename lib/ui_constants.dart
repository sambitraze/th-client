import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIConstants {
  static const double ASSUMED_SCREEN_HEIGHT = 640.0;
  static const double ASSUMED_SCREEN_WIDTH = 360.0;

  static _fitContext(BuildContext context, assumedValue, currentValue, value) =>
      (value / assumedValue) * currentValue;

  static fitToWidth(value, BuildContext context) => _fitContext(
      context, ASSUMED_SCREEN_WIDTH, MediaQuery.of(context).size.width, value);

  static fitToHeight(value, BuildContext context) => _fitContext(context,
      ASSUMED_SCREEN_HEIGHT, MediaQuery.of(context).size.height, value);

  static const mainColor = Color(0xfff2f3f7);
  static const splashScreenLogo = 'assets/images/splashScreenLogo.png';
  static const categoryImage =
      'https://zerobucket.nyc3.digitaloceanspaces.com/category/';
  static const productImage = 'https://zerobucket.nyc3.digitaloceanspaces.com/Products/';
  static const homeServiceImage = 'https://zerobucket.nyc3.digitaloceanspaces.com/homeServices/';

}
