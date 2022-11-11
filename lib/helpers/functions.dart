import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupapplication/helpers/app_config.dart' as config;

class HelperFunctions {
  static String themedata = " THEMEDATA";

  static saveThame({@required String? theme}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(themedata, theme!);
  }

  static Future<String?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(themedata);
  }

  static Future<bool> saveStringValue(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?> getStringValue(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool> clearAllValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      textColor: Colors.white,
      backgroundColor: Colors.black,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
  }

  static BoxDecoration gradientBtnDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      gradient: LinearGradient(
        colors: [
          config.Colors().mainColor(1),
          config.Colors().accentColor(.8),
        ],
      ));
}
