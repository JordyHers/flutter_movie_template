



import 'package:flutter/cupertino.dart';

class SizeConfig{
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;

  }

  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;

  // Padding sizes
  static  double smallPadding = 8;
  static  double mediumPadding = 22.0;
  static  double largePadding = 50.0;
  static  double xlargePadding = 100.0;

  // Button Size
  static const double buttonSizeSmall = 35;
  static const double buttonSizeMedium = 50;

  
}