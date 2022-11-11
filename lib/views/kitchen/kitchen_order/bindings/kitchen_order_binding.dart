import 'package:get/get.dart';

import '../controllers/kitchen_order_controller.dart';

class KitchenOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KitchenOrderController>(
      () => KitchenOrderController(),
    );
  }
}
