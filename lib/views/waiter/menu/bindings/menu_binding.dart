import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/qrController.dart';
import 'package:startupapplication/views/waiter/menu/controllers/cart_controller.dart';

import '../controllers/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuControllers>(
      () => MenuControllers(),
    );
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<GetSharedContoller>(
      () => GetSharedContoller(),
    );
    Get.lazyPut<QrController>(
      () => QrController(),
    );
  }
}
