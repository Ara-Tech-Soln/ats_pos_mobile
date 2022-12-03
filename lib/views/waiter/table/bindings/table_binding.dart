import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/pusher_controller.dart';
import 'package:startupapplication/controllers/qrController.dart';

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
  }
}
