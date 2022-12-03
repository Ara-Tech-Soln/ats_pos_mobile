import 'dart:math';

import 'package:get/get.dart';
import 'package:startupapplication/controllers/ApiBaseController/apiRequestController.dart';
import 'package:startupapplication/controllers/getSharedData.dart';
import 'package:startupapplication/controllers/qrController.dart';
import 'package:startupapplication/helpers/functions.dart';
import 'package:startupapplication/models/Cart.dart';

class CartController extends GetxController {
  ApiRequestController controller = ApiRequestController();
  GetSharedContoller getSharedContoller = Get.find();
  QrController qrController = Get.find();

  var isLoading = true.obs;
  List<Cart?> carts = <Cart>[];
  var tempCart = [];
  var total = 0.00;
  var remainingBalance;

  var orders;
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  addToCart(table_id, menu) async {
    try {
      if (remainingBalance == null) {
        remainingBalance = await qrController.cardDetail.balance;
      }

      var cartTemp =
          tempCart.firstWhere((element) => element!.menuId == menu.id);
      if (cartTemp != null) {
        cartTemp.quantity = (cartTemp.quantity! + 1);
      }
    } catch (e) {
      tempCart.add(
          Cart(menuId: menu.id, menu: menu, quantity: 1, tableId: table_id));
    } finally {
      calculateTotal();
    }
  }

  changeQty(table_id, menu, quantity) async {
    try {
      var cartTemp =
          tempCart.firstWhere((element) => element!.menuId == menu.id);
      if (cartTemp != null) {
        if (quantity == 0) {
          tempCart.remove(cartTemp);
        } else {
          cartTemp.quantity = quantity;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      calculateTotal();
      isLoading(false);
    }
  }

  holdCart(cart) async {
    try {
      isLoading(true);
      await controller
          .holdCart(
              cart: cart,
              token: getSharedContoller.token,
              cardId: qrController.cardDetail.id)
          .then((value) async {
        if (value != null) {
          HelperFunctions.showToast("Cart is on hold now");
          tempCart.clear();
          isLoading(false);
        } else {
          HelperFunctions.showToast("Something went wrong");
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  calculateTotal() {
    total = 0.00;
    tempCart.forEach((element) {
      total = total + (element!.menu!.price! * element.quantity!);
    });
    remainingBalance = qrController.cardDetail.balance! - total;
    print(remainingBalance);

    return total;
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
}
