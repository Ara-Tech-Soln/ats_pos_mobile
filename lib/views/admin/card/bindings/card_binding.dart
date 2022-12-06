import 'package:get/get.dart';
import 'package:startupapplication/controllers/qrController.dart';

import '../controllers/card_controller.dart';

class CardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardController>(
      () => CardController(),
    );
    Get.lazyPut<QrController>(
      () => QrController(),
    );
  }
}
