// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/pushNotificationController.dart';
import 'package:startupapplication/controllers/pusher_controller.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/waiter/table/controllers/table_controller.dart';

class TableView extends StatefulWidget {
  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  NotificationController notificationController =
      Get.put(NotificationController());
  PusherController pusherController = Get.find();
  TableController tableController = Get.find();
  GetSharedContoller getSharedController = Get.find();

  @override
  void initState() {
    tableController.getTables();
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
          title: const Text('ATS POS MOBILE'),
          centerTitle: true,
          actions: [
            //qr code
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.qr_code),
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                tableController.getTables();
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await HelperFunctions.clearAllValue();
                Get.offNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            tableController.getTables();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Obx(
              () => tableController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : tableController.tables.isEmpty
                      ? Center(
                          child: Text("No Tables"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: tableController.tables.length,
                                itemBuilder: (context, index) {
                                  var table = tableController.tables[index]!;
                                  return tableController.tables.length == 0
                                      ? Center(child: Text('No Tables'))
                                      : Card(
                                          color: table.status == 'open'
                                              ? Colors.green
                                              : Colors.red,
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed(Routes.MENU,
                                                  arguments: [
                                                    table.id,
                                                    table.name
                                                  ]);
                                            },
                                            onLongPress: (() {
                                              showSwapDialog(table,
                                                  tableController.tables);
                                            }),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .table_restaurant_rounded,
                                                    size: 50,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                  ),
                                                  Text(
                                                    table.name!,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                }),
                          ),
                        ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Routes.WAITER_ORDER);
          },
          icon: const Icon(Icons.restaurant_menu),
          label: const Text('View Orders'),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }

  showSwapDialog(table, tables) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Swap ' + table.name! + ' with:'),
            content: Container(
              width: 150,
              color: Theme.of(context).primaryColor,
              child: new DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select Destination Table'),
                items: tables
                    .map<DropdownMenuItem<String>>(
                        (value) => new DropdownMenuItem<String>(
                              value: value.id,
                              child: new Text(value.name!),
                            ))
                    .toList(),
                onChanged: (value) {
                  tableController.swapTable(table.id, value);
                  tableController.getTables();
                  Navigator.pop(context);
                },
              ),
            ),
            //dropdown

            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          );
        });
  }
}
