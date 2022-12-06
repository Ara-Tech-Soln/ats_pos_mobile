import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/splash_screen_controller.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/User.dart';
import 'package:startupapplication/routes/app_pages.dart';

class LoginController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.put(GetSharedContoller());
  SplashScreenController splashScreenController =
      Get.put(SplashScreenController());
  var isLoading = false.obs;
  var email;
  var password;
  var deviceTokenToSendPushNotification;
  var loginData = User();

  //onInit
  @override
  void onInit() {
    getDeviceTokenToSendNotification();
    super.onInit();
  }

  login() async {
    try {
      isLoading(true);
      var response = await controller.login(
        email: email,
        password: password,
      );
      if (response != null) {
        loginData = response;
        HelperFunctions.saveStringValue('token', loginData.apiToken);
        HelperFunctions.saveStringValue('role', loginData.roles.toString());
        await updateDeviceToken();
        await getSharedContoller.sharedPreferenceData();

        loginData.roles == 'waiter'
            ? Get.toNamed(Routes.TABLE)
            : loginData.roles == 'kitchen'
                ? Get.toNamed(Routes.KITCHEN_ORDER)
                : loginData.roles == 'bar'
                    ? Get.toNamed(Routes.BAR_ORDER)
                    : splashScreenController.setting.value == "Card" &&
                            (loginData.roles == 'manager' ||
                                loginData.roles == 'cashier')
                        ? Get.toNamed(Routes.CARD)
                        : Get.toNamed(Routes.LOGIN);

        print(response);
      }
      isLoading(false);
    } catch (e) {
      HelperFunctions.showToast(e.toString());
      print(e);
    } finally {
      await isLoading(false);
    }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  updateDeviceToken() async {
    try {
      isLoading(true);
      var response = await controller.updateDeviceToken(
        deviceToken: deviceTokenToSendPushNotification,
        token: loginData.apiToken,
      );
      if (response != null) {
        print(response);
      }
      isLoading(false);
    } catch (e) {
      print(e);
    } finally {
      await isLoading(false);
    }
  }
}
