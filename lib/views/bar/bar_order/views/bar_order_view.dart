import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:startupapplication/controllers/pushNotificationController.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/bar/bar_order/controllers/bar_order_controller.dart';

class BarOrderView extends StatefulWidget {
  const BarOrderView({Key? key}) : super(key: key);

  @override
  State<BarOrderView> createState() => _BarOrderViewState();
}

class _BarOrderViewState extends State<BarOrderView> {
  NotificationController notificationController =
      Get.put(NotificationController());
  BarOrderController barOrderController = Get.find();
  @override
  void initState() {
    barOrderController.allOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Bar Order'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await barOrderController.allOrder();
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
            barOrderController.allOrder();
          },
          child: Obx(() => barOrderController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : barOrderController.orders.isEmpty
                  ? Center(
                      child: Text('No Orders Yet'),
                    )
                  : ListView.builder(
                      itemCount: barOrderController.orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color:
                              barOrderController.orders[index].status == "hold"
                                  ? Colors.red
                                  : barOrderController.orders[index].status ==
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
                                          value: barOrderController.status,
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
                                            barOrderController.changeStatus(
                                              barOrderController
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
                                barOrderController.orders[index].image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Order For ${barOrderController.orders[index].table}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(barOrderController.orders[index].name!
                                            .toUpperCase() +
                                        ' x ' +
                                        barOrderController
                                            .orders[index].quantity
                                            .toString()),
                                    Text(
                                        'Batch  ${barOrderController.orders[index].group}'),
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
                                          value: double.parse(barOrderController
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
                                              barOrderController
                                                      .orders[index].type! +
                                                  " Item",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Status: " +
                                                  barOrderController
                                                      .orders[index].status!
                                                      .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Order Created: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(barOrderController
                                                      .orders[index]
                                                      .createdAt!),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Order Updated: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(barOrderController
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
