import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/waiter/waiter_order/controllers/waiter_order_controller.dart';

class WaiterOrderView extends StatefulWidget {
  const WaiterOrderView({Key? key}) : super(key: key);

  @override
  State<WaiterOrderView> createState() => _WaiterOrderViewState();
}

class _WaiterOrderViewState extends State<WaiterOrderView> {
  WaiterOrderController waiterOrderController = Get.find();
  @override
  void initState() {
    waiterOrderController.allOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text(' Orders'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                await waiterOrderController.allOrder();
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
            waiterOrderController.allOrder();
          },
          child: Obx(() => waiterOrderController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : waiterOrderController.orders.isEmpty
                  ? Center(
                      child: Text('No Orders Yet'),
                    )
                  : ListView.builder(
                      itemCount: waiterOrderController.orders.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: waiterOrderController.orders[index].status ==
                                  "hold"
                              ? Colors.red[300]
                              : waiterOrderController.orders[index].status ==
                                      "preparing"
                                  ? Colors.amber
                                  : Colors.green[300],
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                waiterOrderController.orders[index].image!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Order For ${waiterOrderController.orders[index].table}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(waiterOrderController
                                            .orders[index].name!
                                            .toUpperCase() +
                                        ' x ' +
                                        waiterOrderController
                                            .orders[index].quantity
                                            .toString()),
                                    Text(
                                        'Batch  ${waiterOrderController.orders[index].group}'),
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
                                                  waiterOrderController
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
                                              waiterOrderController
                                                      .orders[index].type! +
                                                  " Item",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              "Status: " +
                                                  waiterOrderController
                                                      .orders[index].status!,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Order Created: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(waiterOrderController
                                                      .orders[index]
                                                      .createdAt!),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Order Updated: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(waiterOrderController
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
