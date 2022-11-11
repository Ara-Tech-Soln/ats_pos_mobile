import 'package:get/get.dart';

import '../controllers/bar_order_controller.dart';

class BarOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarOrderController>(
      () => BarOrderController(),
    );
  }
}
