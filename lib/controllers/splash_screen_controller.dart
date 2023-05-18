import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/models/Setting.dart';

class SplashScreenController extends GetxController {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  ApiRequestController controller = ApiRequestController();
  GlobalKey<ScaffoldState>? scaffoldKey;
  SplashScreenController() {
    progress.value = {"Setting": 0};
  }
  var isLoading = false.obs;
  var setting = Setting();

  @override
  void onInit() {
    progress.value["Setting"] = 100;
    getSettings();
    super.onInit();
  }

  getSettings() async {
    try {
      isLoading(true);
      var response = await controller.getSettings();
      print(response);
      if (response != null) {
        setting = response;
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
