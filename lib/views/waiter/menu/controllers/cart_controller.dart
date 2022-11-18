import 'dart:math';

import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Cart.dart';

class CartController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();

  var isLoading = true.obs;
  var isCartLoading = true.obs;
  List<Cart?> carts = <Cart>[];
  var orders;
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  var total;

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  getCart(table_id) async {
    try {
      isCartLoading(true);
      await controller
          .getCart(table_id: table_id, token: getSharedContoller.token)
          .then((value) {
        value != null ? carts = value : null;

        isCartLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isCartLoading(false);
    }
  }

  addToCart(table_id, menu_id) async {
    //check if menu_id already exist in cart
    try {
      var cart = carts.firstWhere((element) => element!.menuId == menu_id);
      if (cart != null) {
        changeQty(table_id, menu_id, cart.group, cart.quantity! + 1);
        await getCart(table_id);
      }
    } catch (e) {
      try {
        isLoading(true);
        await controller
            .addToCart(
                table_id: table_id,
                menu_id: menu_id,
                group: //if cart is empty then generate random number
                    carts.length == 0
                        ? getRandomString(5).toUpperCase()
                        : carts[0]!.group,
                token: getSharedContoller.token)
            .then((value) async {
          await getCart(table_id);
          isLoading(false);
        });
      } catch (e) {
        getCart(table_id);
        print(e);
      } finally {
        isLoading(false);
      }
    }
  }

  changeQty(table_id, menu_id, group, quantity) async {
    try {
      await controller
          .changeQty(
              table_id: table_id,
              menu_id: menu_id,
              group: group,
              quantity: quantity,
              token: getSharedContoller.token)
          .then((value) async {});
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  emptyCart(table_id) async {
    try {
      isLoading(true);
      await controller
          .emptyCart(table_id: table_id, token: getSharedContoller.token)
          .then((value) {
        HelperFunctions.showToast("Cart is empty now");
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  deleteItem(table_id, menu_id) async {
    try {
      isLoading(true);
      await controller
          .deleteItem(
              table_id: table_id,
              menu_id: menu_id,
              token: getSharedContoller.token)
          .then((value) {
        HelperFunctions.showToast("Item deleted Successfully");
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  orderDetails(table_id) async {
    try {
      isLoading(true);
      await controller
          .orderDetails(table_id: table_id, token: getSharedContoller.token)
          .then((value) {
        value != null ? orders = value : null;
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  holdCart(table_id) async {
    try {
      isLoading(true);
      await controller
          .holdCart(table_id: table_id, token: getSharedContoller.token)
          .then((value) {
        print('hold process');
        getCart(table_id);

        HelperFunctions.showToast("Cart is on hold now");
        isLoading(false);
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
