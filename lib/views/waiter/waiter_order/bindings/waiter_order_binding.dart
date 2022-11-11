import 'package:get/get.dart';

import '../controllers/waiter_order_controller.dart';

class WaiterOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaiterOrderController>(
      () => WaiterOrderController(),
    );
  }
}
