// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:pusher_channels/pusher_channels.dart';
import 'package:startupapplication/views/waiter/table/controllers/table_controller.dart';

class PusherController extends GetxController {
  TableController tableController = Get.find();
  var isLoaded = false.obs;
  var response = [].obs;

  //init
  @override
  void onInit() async {
    super.onInit();
    await refreshTable();
    await recivedOrder();
    await orderReady();
  }

  refreshTable() async {
    try {
      final pusher = Pusher(
        key: '08e8b3a774396baa2bcc',
        cluster: 'ap2',
      );
      await pusher.connect();
      var channel = pusher.subscribe('test-channel');
      channel.eventCallbacks['test-event'] = (data) async {
        if (data != null) {
          await tableController.getTables();
        }
      };
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoaded.value = false;
    }
  }

  recivedOrder() async {
    try {
      final pusher = Pusher(
        key: '08e8b3a774396baa2bcc',
        cluster: 'ap2',
      );
      await pusher.connect();
      var channel = pusher.subscribe('test-channel');
      channel.eventCallbacks['test-event'] = (data) async {
        if (data != null) {
          await tableController.getTables();
        }
      };
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoaded.value = false;
    }
  }

  orderReady() async {
    try {
      final pusher = Pusher(
        key: '08e8b3a774396baa2bcc',
        cluster: 'ap2',
      );
      await pusher.connect();
      var channel = pusher.subscribe('test-channel');
      channel.eventCallbacks['test-event'] = (data) async {
        if (data != null) {
          await tableController.getTables();
        }
      };
    } catch (e) {
      print("ERROR: $e");
    } finally {
      isLoaded.value = false;
    }
  }
}
