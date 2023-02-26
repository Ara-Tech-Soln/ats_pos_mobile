import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:startupapplication/helpers/app_config.dart' as config;
import 'package:startupapplication/helpers/themeService.dart';
import 'package:startupapplication/services/local_notification_service.dart';
import 'routes/app_pages.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();
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
        dividerColor: config.Colors().accentColor(0.1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
              fontSize: 20.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1),
              height: 1.35),
          displaySmall: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1),
              height: 1.35),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainColor(1),
              height: 1.35),
          displayLarge: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondColor(1),
              height: 1.5),
          titleMedium: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondColor(1),
              height: 1.35),
          titleLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainColor(1),
              height: 1.35),
          bodyMedium: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          bodyLarge: TextStyle(
              fontSize: 14.0,
              color: config.Colors().secondColor(1),
              height: 1.35),
          bodySmall: TextStyle(
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
        dividerColor: config.Colors().accentColor(0.1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          headlineSmall: TextStyle(
              fontSize: 20.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          displaySmall: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          displayMedium: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainDarkColor(1),
              height: 1.35),
          displayLarge: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondDarkColor(1),
              height: 1.5),
          titleMedium: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          titleLarge: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainDarkColor(1),
              height: 1.35),
          bodyMedium: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          bodyLarge: TextStyle(
              fontSize: 14.0,
              color: config.Colors().secondDarkColor(1),
              height: 1.35),
          bodySmall: TextStyle(
              fontSize: 12.0,
              color: config.Colors().secondDarkColor(0.6),
              height: 1.35),
        ),
      ),
    );
  }
}
