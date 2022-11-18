import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/routes/app_pages.dart';
import 'package:startupapplication/views/waiter/menu/controllers/cart_controller.dart';
import 'package:startupapplication/views/waiter/menu/controllers/menu_controller.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  var tableId = Get.arguments[0];
  var tableName = Get.arguments[1];
  var changeQty;

  MenuController menuController = Get.find();
  CartController cartController = Get.find();
  @override
  void initState() {
    cartController.getCart(tableId);
    menuController.getMenus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(tableName),
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
          cartController.getCart(tableId);
        },
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                child: Obx(
                  (() => cartController.isCartLoading.value
                      ? Text('Loading...')
                      : cartController.carts.isEmpty
                          ? Center(
                              child: Text('No Items in Cart'),
                            )
                          : DataTable(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              columnSpacing: 40,
                              dataRowColor:
                                  MaterialStateProperty.all(Colors.white),
                              dataTextStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              border: TableBorder.all(),
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey.shade800),
                              headingTextStyle: TextStyle(color: Colors.white),
                              columns: const [
                                DataColumn(label: Text('Name')),
                                DataColumn(label: Text('Quantity')),
                                DataColumn(label: Text('Total')),
                              ],
                              rows: List.generate(
                                cartController.carts.length,
                                (index) => DataRow(
                                  cells: [
                                    DataCell(Text(cartController
                                        .carts[index]!.menu!.name!)),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await cartController.changeQty(
                                                tableId,
                                                cartController
                                                    .carts[index]!.menu!.id!,
                                                cartController
                                                    .carts[index]!.group!,
                                                cartController.carts[index]!
                                                        .quantity! -
                                                    1);
                                            await cartController
                                                .getCart(tableId);
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 15,
                                            color: Colors.amber,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
//get dialog
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Change Quantity'),
                                                    content: Container(
                                                      height: 100,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                              'Current Quantity: ${cartController.carts[index]!.quantity}'),
                                                          TextFormField(
                                                              initialValue:
                                                                  cartController
                                                                      .carts[
                                                                          index]!
                                                                      .quantity
                                                                      .toString(),
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    'Enter Quantity',
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                changeQty =
                                                                    value;
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await cartController.changeQty(
                                                                tableId,
                                                                cartController
                                                                    .carts[
                                                                        index]!
                                                                    .menu!
                                                                    .id!,
                                                                cartController
                                                                    .carts[
                                                                        index]!
                                                                    .group!,
                                                                int.parse(
                                                                    changeQty));
                                                            await cartController
                                                                .getCart(
                                                                    tableId);

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text('Change')),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text(
                                            cartController
                                                .carts[index]!.quantity
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            cartController.changeQty(
                                                tableId,
                                                cartController
                                                    .carts[index]!.menu!.id!,
                                                cartController
                                                    .carts[index]!.group!,
                                                cartController.carts[index]!
                                                        .quantity! +
                                                    1);
                                            await cartController
                                                .getCart(tableId);
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.green,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await cartController.deleteItem(
                                                cartController
                                                    .carts[index]!.tableId!,
                                                cartController
                                                    .carts[index]!.menuId!);
                                            await cartController
                                                .getCart(tableId);
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
                                          'RS.${(cartController.carts[index]!.menu!.price! * cartController.carts[index]!.quantity!).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                ),
              ),
            ),
            Obx(() => cartController.isCartLoading.value
                ? Container()
                : cartController.carts.isEmpty
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (() async {
                              await cartController.emptyCart(tableId);
                              await cartController.getCart(tableId);
                            }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 224, 7, 7),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Empty Cart',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (() {
                              cartController.holdCart(tableId);
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
                          )
                        ],
                      )),
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
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await cartController.addToCart(
                                      tableId,
                                      menuController.menus[index]!.id!,
                                    );
                                    await cartController.getCart(tableId);
                                    setState(() {});
                                  },
                                  child: GridTile(
                                    child: Image.network(
                                      menuController.menus[index]!.image!,
                                      fit: BoxFit.cover,
                                    ),
                                    footer: GridTileBar(
                                      title: Text(
                                        menuController.menus[index]!.name!,
                                        textAlign: TextAlign.center,
                                        softWrap: true,
                                        style: TextStyle(
                                            overflow: TextOverflow.visible),
                                      ),
                                      backgroundColor: Colors.black54,
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
