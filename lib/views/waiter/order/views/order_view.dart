import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:startupapplication/views/waiter/order/controllers/order_controller.dart';

class OrderView extends StatefulWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  var tableId = Get.arguments[0];
  var tableName = Get.arguments[1];
  OrderController orderController = Get.find();

  @override
  void initState() {
    orderController.orderDetails(tableId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Order for ${tableName}',
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          orderController.orderDetails(tableId);
        },
        child: Obx(() => orderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : orderController.orders.isEmpty
                ? Center(
                    child: Text('No Orders Yet'),
                  )
                : ListView.builder(
                    itemCount: orderController.orders.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: orderController.orders[index].status == 'hold'
                            ? Colors.red
                            : orderController.orders[index].status ==
                                    'preparing'
                                ? Colors.amber
                                : Colors.green,
                        child: ListTile(
                          leading: ClipOval(
                            child: Image.network(
                              orderController.orders[index].image!,
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            orderController.orders[index].name!.toUpperCase() +
                                ' x ' +
                                orderController.orders[index].quantity
                                    .toString(),
                            style: TextStyle(fontSize: 12),
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
                                        value: double.parse(orderController
                                                .orders[index].progress
                                                .toString()) /
                                            100,
                                        backgroundColor: Colors.grey,
                                        valueColor: AlwaysStoppedAnimation<
                                                Color>(
                                            Color.fromARGB(255, 125, 29, 173)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            orderController
                                                    .orders[index].type! +
                                                " Item",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "Status: " +
                                                orderController
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
                                                  .format(orderController
                                                      .orders[index]
                                                      .createdAt!),
                                          style:
                                              TextStyle(color: Colors.black)),
                                      Text(
                                          'Order Updated: ' +
                                              DateFormat('dd-MM-yyyy hh:mm a')
                                                  .format(orderController
                                                      .orders[index]
                                                      .updatedAt!),
                                          style:
                                              TextStyle(color: Colors.black)),
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
    );
  }
}
