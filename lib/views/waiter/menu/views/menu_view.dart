import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/qrController.dart';
import 'package:startupapplication/controllers/splash_screen_controller.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/waiter/menu/controllers/cart_controller.dart';
import 'package:startupapplication/views/waiter/menu/controllers/menu_controller.dart';
import 'package:startupapplication/views/waiter/table/controllers/table_controller.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  var tableId = Get.arguments[0];
  var tableName = Get.arguments[1];
  var changeQty;
  SplashScreenController settingController = Get.find();
  MenuControllers menuController = Get.find();
  CartController cartController = Get.find();
  TableController tableController = Get.find();
  QrController qrController = Get.find();
  @override
  void initState() {
    //cartController.getCart(tableId);
    menuController.getMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(tableName!),
        centerTitle: true,
        actions: [
          //view orders
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.ORDER, arguments: [tableId, tableName]);
              },
              icon: const Icon(
                Icons.food_bank_rounded,
                size: 40,
              )),
          //empty cart
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          menuController.getMenus();
          //cartController.getCart(tableId);
        },
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                  child: DataTable(
                //columnSpacing: 40,
                dataRowColor: MaterialStateProperty.all(Colors.white),
                dataTextStyle: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                border: TableBorder.all(),
                columnSpacing: 20,
                horizontalMargin: 2,

                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade800),
                headingTextStyle: TextStyle(color: Colors.white),
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Quantity')),
                  DataColumn(label: Text('Total')),
                ],
                rows: List.generate(
                  cartController.tempCart.length,
                  (index) => DataRow(
                    cells: [
                      DataCell(
                          Text(cartController.tempCart[index]!.menu!.name)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cartController.changeQty(
                                  tableId,
                                  cartController.tempCart[index]!.menu!,
                                  cartController.tempCart[index]!.quantity! -
                                      1);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 15,
                              color: Colors.amber,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Change Quantity'),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                                'Current Quantity: ${cartController.tempCart[index]!.quantity}'),
                                            TextFormField(
                                                initialValue: cartController
                                                    .tempCart[index]!.quantity
                                                    .toString(),
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Enter Quantity',
                                                ),
                                                onChanged: (value) {
                                                  changeQty = value;
                                                }),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              if (settingController
                                                      .setting.value ==
                                                  "Card") {
                                                if (cartController
                                                        .remainingBalance <=
                                                    menuController
                                                        .menus[index]!.price!) {
                                                  HelperFunctions.showToast(
                                                      'Card Balance is not enough');
                                                  return;
                                                }
                                                cartController.changeQty(
                                                    tableId,
                                                    cartController
                                                        .tempCart[index]!.menu!,
                                                    int.parse(changeQty));
                                                setState(() {});

                                                Navigator.pop(context);
                                              } else {
                                                cartController.changeQty(
                                                    tableId,
                                                    cartController
                                                        .tempCart[index]!.menu!,
                                                    int.parse(changeQty));
                                                setState(() {});

                                                Navigator.pop(context);
                                              }
                                              ;
                                            },
                                            child: Text('Change')),
                                      ],
                                    );
                                  });
                            },
                            child: Text(
                              cartController.tempCart[index]!.quantity
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (settingController.setting.value == "Card") {
                                if (cartController.remainingBalance <=
                                    menuController.menus[index]!.price!) {
                                  HelperFunctions.showToast(
                                      'Card Balance is not enough');
                                  return;
                                }
                                cartController.changeQty(
                                    tableId,
                                    cartController.tempCart[index]!.menu!,
                                    cartController.tempCart[index]!.quantity! +
                                        1);
                                setState(() {});
                              } else {
                                cartController.changeQty(
                                    tableId,
                                    cartController.tempCart[index]!.menu!,
                                    cartController.tempCart[index]!.quantity! +
                                        1);
                                setState(() {});
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              cartController.changeQty(tableId,
                                  cartController.tempCart[index]!.menu!, 0);
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )),
                      DataCell(
                        Container(
                          child: Text(
                            'RS.${(cartController.tempCart[index]!.menu!.price! * cartController.tempCart[index]!.quantity!).toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                settingController.setting.value == "Cash"
                    ? Obx(() => qrController.isLoading.value
                        ? Text('Loading')
                        : Text(
                            'Total: RS.${cartController.total.toStringAsFixed(2)}'))
                    : Obx(() => qrController.isLoading.value
                        ? Text('Loading')
                        : cartController.remainingBalance == null
                            ? Container()
                            : Text(
                                'Available Balance of Card: ${cartController.remainingBalance}')),
                Obx(() => cartController.isLoading.value
                    ? Text('Please Wait')
                    : InkWell(
                        onTap: (() async {
                          if (settingController.setting.value == "Card") {
                            if (cartController.tempCart.length == 0) {
                              HelperFunctions.showToast('Cart is Empty');
                            } else if (cartController.remainingBalance <=
                                0.00) {
                              HelperFunctions.showToast(
                                  'Card Balance is not enough');
                              return;
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Confirm Order'),
                                      content: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        child: Column(
                                          children: [
                                            Text('Table Number: '),

                                            //items in cart
                                            Text('Items:'),
                                            for (var i
                                                in cartController.tempCart)
                                              Text(
                                                  '${i!.menu!.name} x ${i.quantity}'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            alignment: Alignment.center,
                                            decoration: HelperFunctions
                                                .gradientBtnDecoration,
                                            child: Text('Cancel',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.back();
                                            await cartController.holdCart(
                                                cartController.tempCart);
                                            tableController.getTables();
                                            setState(() {});
                                          },
                                          child: Container(
                                            height: 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            alignment: Alignment.center,
                                            decoration: HelperFunctions
                                                .gradientBtnDecoration,
                                            child: Text('Confirm',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17)),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirm Order'),
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: Column(
                                        children: [
                                          Text('Table Number: '),

                                          //items in cart
                                          Text('Items:'),
                                          for (var i in cartController.tempCart)
                                            Text(
                                                '${i!.menu!.name} x ${i.quantity}'),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          alignment: Alignment.center,
                                          decoration: HelperFunctions
                                              .gradientBtnDecoration,
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17)),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Get.back();
                                          await cartController.holdCart(
                                              cartController.tempCart);
                                          tableController.getTables();
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 35,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          alignment: Alignment.center,
                                          decoration: HelperFunctions
                                              .gradientBtnDecoration,
                                          child: Text('Confirm',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17)),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          }
                        }),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 7, 21, 224),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Make Order',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  menuController.query = value;
                  menuController.getMenus();
                },
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Obx(
                  () => menuController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : menuController.menus.isEmpty
                          ? const Center(
                              child: Text("No Menus"),
                            )
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 1.0,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemCount: menuController.menus.length,
                              clipBehavior: Clip.antiAlias,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (settingController.setting.value ==
                                        "Card") {
                                      if (cartController.remainingBalance <=
                                          menuController.menus[index]!.price!) {
                                        HelperFunctions.showToast(
                                            'Card Balance is not enough');
                                        return;
                                      }
                                      cartController.addToCart(tableId,
                                          menuController.menus[index]!);

                                      setState(() {});
                                    } else {
                                      cartController.addToCart(tableId,
                                          menuController.menus[index]!);

                                      setState(() {});
                                    }
                                  },
                                  child: GridTile(
                                    // child: menuController.menus[index]!.image ==
                                    //         ""
                                    //     ? Image.network(
                                    //         'https://t3.ftcdn.net/jpg/04/34/72/82/360_F_434728286_OWQQvAFoXZLdGHlObozsolNeuSxhpr84.jpg',
                                    //         fit: BoxFit.cover,
                                    //       )
                                    //     : Image.network(
                                    //         menuController.menus[index]!.image!,
                                    //         fit: BoxFit.cover,
                                    //       ),
                                    child: GridTileBar(
                                      title: Text(
                                        menuController.menus[index]!.name!,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: TextStyle(
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      backgroundColor: Colors.black38,
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
