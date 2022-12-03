import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/pusher_controller.dart';
import 'package:startupapplication/controllers/qrController.dart';
import 'package:startupapplication/views/waiter/menu/controllers/cart_controller.dart';
import 'package:startupapplication/views/waiter/order/controllers/order_controller.dart';

import '../controllers/table_controller.dart';

class TableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableController>(
      () => TableController(),
    );
    Get.lazyPut<GetSharedContoller>(
      () => GetSharedContoller(),
    );
    Get.lazyPut<PusherController>(
      () => PusherController(),
    );
    Get.lazyPut<QrController>(
      () => QrController(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
  }
}
