import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/models/Order.dart';

class OrderController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  var isLoading = true.obs;
  List<Order> orders = <Order>[];
  orderDetails(table_id) async {
    try {
      isLoading(true);
      await controller
          .orderDetails(table_id: table_id, token: getSharedContoller.token)
          .then((value) {
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
