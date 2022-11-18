import 'package:flutter/material.dart';

class App {
  BuildContext? _context;
  double? _height;
  double? _width;
  double? _heightPadding;
  double? _widthPadding;

  App(_context) {
    this._context = _context;
    MediaQueryData _queryData = MediaQuery.of(this._context!);
    _height = _queryData.size.height / 100.0;
    _width = _queryData.size.width / 100.0;
    _heightPadding = (_height! -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0));
    _widthPadding = (_width! -
        (_queryData.padding.left + _queryData.padding.right) / 100.0);
  }

  double appHeight(double v) {
    return _height! * v;
  }

  double appWidth(double v) {
    return _width! * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding! * v;
  }

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding! * v;
  }
}

class Colors {
  Color mainColor(double opacity) {
    return Color.fromARGB(249, 228, 27, 27).withOpacity(opacity);
  }

  Color secondColor(double opacity) {
    return Color(0xFF090101).withOpacity(opacity);
  }

  Color accentColor(double opacity) {
    return Color(0xFFCCCCCC).withOpacity(opacity);
  }

  Color mainDarkColor(double opacity) {
    return Color(0xFFCCCCCC).withOpacity(opacity);
  }

  Color secondDarkColor(double opacity) {
    return Color(0xFFCCCCCC).withOpacity(opacity);
  }

  Color accentDarkColor(double opacity) {
    return Color(0xFFCCCCCC).withOpacity(opacity);
  }

  Color scaffoldColor(double opacity) {
    return Color(0xFFCCCCCC).withOpacity(opacity);
  }
}
