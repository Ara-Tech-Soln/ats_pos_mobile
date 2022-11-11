import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';

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
  }
}
