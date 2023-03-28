import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';

class WelcomeContoller extends GetxController {
  GetSharedContoller getSharedContoller = Get.put(GetSharedContoller());
  ApiRequestController controller = ApiRequestController();

  String? ipUrl;

  var isLoading = true.obs;

  setIp() {
    try {
      isLoading(true);

      if (ipUrl!.contains('http://') || ipUrl!.contains('https://')) {
        checkValidIp();
      } else {
        HelperFunctions.showToast('Please Enter Valid Url');
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      print(e);
    }
  }

  checkValidIp() async {
    try {
      isLoading(true);
      var response = await controller.checkValidIp(ipUrl!);
      print(response);
      if (response != null) {
        HelperFunctions.saveStringValue('ipUrl', ipUrl!);
        HelperFunctions.showToast('IP Address Saved Successfully');
        Get.toNamed(Routes.SPLASH);
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
