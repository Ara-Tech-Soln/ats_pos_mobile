import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlankScreenController extends GetxController {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());

  GlobalKey<ScaffoldState>? scaffoldKey;
  SplashScreenController() {
    progress.value = {"Setting": 0};
  }

  var isLoading = false.obs;

  @override
  void onInit() {
    progress.value["Setting"] = 100;

    super.onInit();
  }
}
