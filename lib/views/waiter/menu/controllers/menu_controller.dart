import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/models/Menu.dart';

class MenuController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();

  var isLoading = true.obs;
  List<Menu?> menus = <Menu>[];
  String query = '';

  getMenus() async {
    try {
      isLoading(true);
      await controller
          .getMenus(query: query, token: getSharedContoller.token)
          .then((value) {
        value != null ? menus.assignAll(value) : null;
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
