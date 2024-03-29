import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/splash_screen_controller.dart';
import 'package:startupapplication/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.put(SplashScreenController());
  GetSharedContoller getSharedContoller = Get.put(GetSharedContoller());
  @override
  @override
  void initState() {
    super.initState();
    controller.getSettings();
    loadData();
  }

  void loadData() {
    double progress = 100;

    if (progress == 100) {
      try {
        Timer(Duration(seconds: 2), () {
          getSharedContoller.token == null
              ? Get.offNamed(Routes.LOGIN)
              : getSharedContoller.role == 'waiter'
                  ? Get.toNamed(Routes.TABLE)
                  : getSharedContoller.role == 'kitchen'
                      ? Get.toNamed(Routes.KITCHEN_ORDER)
                      : getSharedContoller.role == 'bar'
                          ? Get.toNamed(Routes.BAR_ORDER)
                          : controller.setting.value == "Card" &&
                                  (getSharedContoller.role == 'manager' ||
                                      getSharedContoller.role == 'cashier')
                              ? Get.toNamed(Routes.CARD)
                              : Get.toNamed(Routes.LOGIN);
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
