import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/User.dart';
import 'package:startupapplication/routes/app_pages.dart';

class LoginController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.put(GetSharedContoller());
  var isLoading = false.obs;
  var email;
  var password;
  var loginData = User();

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
        await getSharedContoller.sharedPreferenceData();
        loginData.roles == 'waiter'
            ? Get.toNamed(Routes.TABLE)
            : loginData.roles == 'kitchen'
                ? Get.toNamed(Routes.KITCHEN_ORDER)
                : loginData.roles == 'bar'
                    ? Get.toNamed(Routes.BAR_ORDER)
                    : Get.offAll(Routes.LOGIN);

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
