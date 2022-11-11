import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  //show error dialog
  static void showErrorDialog(
      {String title = "Error", String description = 'Something went wrong'}) {
    Get.dialog(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 150,
                ),
                Text(
                  title,
                  style: Get.textTheme.headline4,
                ),
                Text(
                  description,
                  style: Get.textTheme.headline6,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: (() async {
                        Get.back(closeOverlays: true);
                        if (Get.isDialogOpen!) Get.back();
                      }),
                      child: Text('OKey')),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
