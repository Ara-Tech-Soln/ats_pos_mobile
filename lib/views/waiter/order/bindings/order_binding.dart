import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';

import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<GetSharedContoller>(
      () => GetSharedContoller(),
    );
  }
}
