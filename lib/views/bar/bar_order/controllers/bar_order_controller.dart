import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Order.dart';

class BarOrderController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  var isLoading = true.obs;
  var status = 'Select Status';
  List<Order> orders = <Order>[];
  allOrder() async {
    try {
      isLoading(true);
      await controller.allOrder(token: getSharedContoller.token).then((value) {
        value != null
            ? orders = value
                .where((element) =>
                    element.type == 'Bar' && element.status != 'serving')
                .toList()
            : null;

        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  changeStatus(cart_id, status) async {
    if (status == 'Select Status') {
      HelperFunctions.showToast('Please Select Status');

      return;
    }
    try {
      isLoading(true);
      await controller
          .changeStatus(
        cart_id: cart_id,
        status: status,
        token: getSharedContoller.token,
      )
          .then((value) async {
        value != null ? print(value) : null;
        HelperFunctions.showToast('Status Changed');
        await allOrder();
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
