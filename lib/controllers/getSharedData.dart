import 'package:get/get.dart';
import 'package:startupapplication/helpers/functions.dart';

class GetSharedContoller extends GetxController {
  String? token;
  String? role;
  String? ipUrl;
  String? email;

  var isLoading = true.obs;
  @override
  void onInit() {
    sharedPreferenceData();
    super.onInit();
  }

  Future<void> sharedPreferenceData() async {
    isLoading(true);

    HelperFunctions.getStringValue('token').then((value) {
      token = value;
    });
    HelperFunctions.getStringValue('role').then((value) {
      role = value;
    });
    HelperFunctions.getStringValue('ipUrl').then((value) {
      ipUrl = value;
    });
    HelperFunctions.getStringValue('email').then((value) {
      email = value;
    });
    isLoading(false);
  }
}
