import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/blank_screen_controller.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/splash_screen_controller.dart';
import 'package:startupapplication/routes/app_pages.dart';

class BlankScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BlankScreenState();
  }
}

class BlankScreenState extends State<BlankScreen> {
  BlankScreenController controller = Get.put(BlankScreenController());
  GetSharedContoller getSharedContoller = Get.put(GetSharedContoller());
  SplashScreenController cc = Get.put(SplashScreenController());

  @override
  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() {
    double progress = 100;

    if (progress == 100) {
      try {
        Timer(Duration(seconds: 1), () {
          if (getSharedContoller.ipUrl != null) {
            cc.getSettings();
          }
          getSharedContoller.ipUrl == null
              ? Get.offNamed(Routes.WELCOME)
              : getSharedContoller.role == 'waiter'
                  ? Get.toNamed(Routes.TABLE)
                  : getSharedContoller.role == 'kitchen'
                      ? Get.toNamed(Routes.KITCHEN_ORDER)
                      : getSharedContoller.role == 'bar'
                          ? Get.toNamed(Routes.BAR_ORDER)
                          : cc.setting.value == "Card" &&
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
