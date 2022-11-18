import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:startupapplication/controllers/pushNotificationController.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/kitchen/kitchen_order/controllers/kitchen_order_controller.dart';

class KitchenOrderView extends StatefulWidget {
  const KitchenOrderView({Key? key}) : super(key: key);

  @override
  State<KitchenOrderView> createState() => _KitchenOrderViewState();
}

class _KitchenOrderViewState extends State<KitchenOrderView> {
  NotificationController notificationController =
      Get.put(NotificationController());
  KitchenOrderController kitchenOrderController = Get.find();
  @override
  void initState() {
    kitchenOrderController.allOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text('Kitchen Order'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await kitchenOrderController.allOrder();
              },
              icon: const Icon(Icons.refresh),
            ),
            //logout
            IconButton(
              onPressed: () async {
                await HelperFunctions.clearAllValue();
                Get.offNamed(Routes.LOGIN);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            kitchenOrderController.allOrder();
          },
          child: Obx(() => kitchenOrderController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : kitchenOrderController.orders.isEmpty
                  ? Center(
                      child: Text('No Orders Yet'),
                    )
                  : ListView.builder(
                      itemCount: kitchenOrderController.orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: kitchenOrderController.orders[index].status ==
                                  "hold"
                              ? Colors.red
                              : kitchenOrderController.orders[index].status ==
                                      "preparing"
                                  ? Colors.amber
                                  : Colors.green,
                          child: ListTile(
                            trailing: IconButton(
                              iconSize: 35,
                              color: Colors.black,
                              onPressed: () {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text('Change  Order Status'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        //dropdown for status
                                        DropdownButtonFormField(
                                          value: kitchenOrderController.status,
                                          items: [
                                            DropdownMenuItem(
                                              child:
                                                  const Text('Select Status'),
                                              value: 'Select Status',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Preparing'),
                                              value: 'preparing',
                                            ),
                                            DropdownMenuItem(
                                              child: Text('Ready'),
                                              value: 'serving',
                                            ),
                                          ],
                                          onChanged: (value) {
                                            kitchenOrderController.changeStatus(
                                              kitchenOrderController
                                                  .orders[index].cartId
                                                  .toString(),
                                              value.toString(),
                                            );
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(Icons.arrow_drop_down_circle),
                            ),
                            leading: ClipOval(
                              child: Image.network(
                                kitchenOrderController.orders[index].image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Order For ${kitchenOrderController.orders[index].table}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(kitchenOrderController
                                            .orders[index].name!
                                            .toUpperCase() +
                                        ' x ' +
                                        kitchenOrderController
                                            .orders[index].quantity
                                            .toString()),
                                    Text(
                                        'Batch  ${kitchenOrderController.orders[index].group}'),
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                //progress bar
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        LinearProgressIndicator(
                                          minHeight: 10,
                                          value: double.parse(
                                                  kitchenOrderController
                                                      .orders[index].progress
                                                      .toString()) /
                                              100,
                                          backgroundColor: Colors.grey,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color.fromARGB(
                                                      255, 144, 19, 202)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              kitchenOrderController
                                                      .orders[index].type! +
                                                  " Item",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Status: " +
                                                  kitchenOrderController
                                                      .orders[index].status!
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Order Created: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(kitchenOrderController
                                                      .orders[index]
                                                      .createdAt!),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Order Updated: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(kitchenOrderController
                                                      .orders[index]
                                                      .updatedAt!),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
        ),
      ),
    );
  }
}
