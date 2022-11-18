import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/services/local_notification_service.dart';

class NotificationController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  var isLoading = true.obs;
  String? deviceTokenToSendPushNotification;

  var title = " new order from table 5";
  var body = "new order from table 5 body ";
  @override
  void onInit() {
    getDeviceTokenToSendNotification();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          getSharedContoller.role == 'waiter'
              ? Get.toNamed(Routes.WAITER_ORDER)
              : getSharedContoller.role == 'kitchen'
                  ? Get.toNamed(Routes.KITCHEN_ORDER)
                  : getSharedContoller.role == 'bar'
                      ? Get.toNamed(Routes.BAR_ORDER)
                      : print("no role");
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          HelperFunctions.showToast(message.notification!.title!);
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          getSharedContoller.role == 'waiter'
              ? Get.toNamed(Routes.WAITER_ORDER)
              : getSharedContoller.role == 'kitchen'
                  ? Get.toNamed(Routes.KITCHEN_ORDER)
                  : getSharedContoller.role == 'bar'
                      ? Get.toNamed(Routes.BAR_ORDER)
                      : print("no role");
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    super.onInit();
  }

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  // sendNotification() async {
  //   try {
  //     isLoading(true);
  //     var users = await controller.sendNotification(
  //         deviceToken: deviceTokenToSendPushNotification!,
  //         title: title,
  //         body: body);

  //     if (users != null) {}
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
