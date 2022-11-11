import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/models/Order.dart';

class WaiterOrderController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  var isLoading = true.obs;
  var status = 'Select Status';

  List<Order> orders = <Order>[];
  allOrder() async {
    try {
      isLoading(true);
      await controller.allOrder(token: getSharedContoller.token).then((value) {
        value != null ? orders = value : null;

        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
