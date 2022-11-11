import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:startupapplication/helpers/app_config.dart' as config;
import 'package:startupapplication/helpers/themeService.dart';

import 'routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.zoom,
      debugShowCheckedModeBanner: true,
      themeMode: ThemeService().theme,
      theme: ThemeData(
        fontFamily: 'Sign',
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        backgroundColor: config.Colors().mainColor(1),
        dividerColor: config.Colors().accentColor(0.1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 20.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1),
              height: 1.35),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1),
              height: 1.35),
          headline2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainColor(1),
              height: 1.35),
          headline1: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondColor(1),
              height: 1.5),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondColor(1),
              height: 1.35),
          headline6: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainColor(1),
              height: 1.35),
          bodyText2: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          bodyText1: TextStyle(
              fontSize: 14.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          caption: TextStyle(
              fontSize: 12.0,
              color: config.Colors().accentColor(1),
              height: 1.35),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Sign',
        primaryColor: Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2C2C2C),
        backgroundColor: config.Colors().mainDarkColor(1),
        dividerColor: config.Colors().accentColor(0.1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 20.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          headline2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainDarkColor(1),
              height: 1.35),
          headline1: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondDarkColor(1),
              height: 1.5),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          headline6: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainDarkColor(1),
              height: 1.35),
          bodyText2: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          bodyText1: TextStyle(
              fontSize: 14.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          caption: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondDarkColor(0.6),
              height: 1.35),
        ),
      ),
    );
  }
}
