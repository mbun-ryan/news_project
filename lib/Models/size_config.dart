import 'package:flutter/widgets.dart';

class ScreenSizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth - 0;
    blockSizeVertical = screenHeight - 0;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = ((screenWidth > 600 ? screenHeight : screenWidth) -
            _safeAreaHorizontal) /
        100;
    safeBlockVertical =
        ((screenWidth > 600 ? screenWidth : screenHeight) - _safeAreaVertical) /
            100;

    print('$safeBlockHorizontal\n $safeBlockVertical');
  }
}
