import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashScreenController extends GetxController {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState>? scaffoldKey;
  SplashScreenController() {
    progress.value = {"Setting": 0};
  }

  @override
  void onInit() {
    progress.value["Setting"] = 100;

    super.onInit();
  }
}
