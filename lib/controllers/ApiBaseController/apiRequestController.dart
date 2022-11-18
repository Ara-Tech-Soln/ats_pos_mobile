// import 'dart:convert';
// import 'package:get/get.dart';
import 'dart:convert';

import 'package:startupapplication/controllers/ApiBaseController/baseController.dart';
import 'package:startupapplication/models/Cart.dart';
import 'package:startupapplication/models/Menu.dart';
import 'package:startupapplication/models/Order.dart';
import 'package:startupapplication/models/Table.dart';
import 'package:startupapplication/models/User.dart';
import 'package:startupapplication/services/base_client.dart';

class ApiRequestController with BaseController {
  // static String baseUrl = 'http://192.168.100.185';
  static String baseUrl = 'http://vusechho.com';
  // static String baseUrl = 'http://192.168.1.150';
  static String verison = '/api/';
  static String apiBaseUrl = baseUrl + verison;

  login({
    required String email,
    required String password,
  }) async {
    var endPoint = "login";
    var body = jsonEncode({
      "email": email,
      "password": password,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient().post(apiBaseUrl, endPoint, headers, body);
    if (response == null) {
      return response;
    } else {
      print(response);
      return User.fromJson(response);
    }
  }

  updateDeviceToken({String? token, String? deviceToken}) async {
    var endPoint = "update-device-token?api_token=$token";
    var body = jsonEncode({
      "device_token": deviceToken,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient().post(apiBaseUrl, endPoint, headers, body);
    if (response == null) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  getTables({String? token}) async {
    var endPoint = "tables?api_token=$token";
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, null)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return List<Table>.from(
          json.decode(response).map((x) => Table.fromMap(x)));
    }
  }

  swapTable({required table_id, required new_table_id, String? token}) async {
    var endPoint = "carts-swap?table_id=$table_id&new_table_id=$new_table_id" +
        "&api_token=$token";
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, null)
        .catchError(handelError);
    if (response == null) {
      return;
    } else {
      print(response);
      return List<Table>.from(
          json.decode(response).map((x) => Table.fromMap(x)));
    }
  }

  getMenus({String? query, String? token}) async {
    var endPoint = "items?search=" + query! + "&api_token=$token";
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, null)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return List<Menu>.from(json.decode(response).map((x) => Menu.fromMap(x)));
    }
  }

  getCart({String? table_id, String? token}) async {
    var endPoint = "carts?table_id=" + table_id! + "&api_token=$token";

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, headers)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return List<Cart>.from(json.decode(response).map((x) => Cart.fromMap(x)));
    }
  }

  addToCart({
    required menu_id,
    required table_id,
    required group,
    String? token,
  }) async {
    var endPoint = "cart" + "?api_token=$token";
    var body = jsonEncode({
      "menu_id": menu_id,
      "table_id": table_id,
      "group": group,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient().post(apiBaseUrl, endPoint, headers, body);
    if (response == null) {
      return;
    } else {
      print(response);
    }
  }

  changeQty({
    required menu_id,
    required table_id,
    required group,
    required quantity,
    String? token,
  }) async {
    var endPoint = "cart/change-qty" + "?api_token=$token";
    var body = jsonEncode({
      "menu_id": menu_id,
      "table_id": table_id,
      "group": group,
      "quantity": quantity,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient().post(apiBaseUrl, endPoint, headers, body);
    if (response == null) {
      return;
    } else {
      print(response);
      return;
    }
  }

  emptyCart({String? table_id, String? token}) async {
    var endPoint = "carts?table_id=" + table_id! + "&api_token=$token";
    var response =
        await BaseClient().delete(apiBaseUrl, endPoint).catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      // return;
    }
  }

  deleteItem({String? table_id, String? menu_id, String? token}) async {
    var endPoint = "carts-item?table_id=" +
        table_id! +
        "&menu_id=" +
        menu_id! +
        "&api_token=$token";
    var response =
        await BaseClient().delete(apiBaseUrl, endPoint).catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      // return;
    }
  }

  allOrder({String? token}) async {
    var endPoint = "cart-details?api_token=$token";

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, headers)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return List<Order>.from(
          json.decode(response).map((x) => Order.fromMap(x)));
    }
  }

  orderDetails({String? table_id, String? token}) async {
    var endPoint = "order-details?table_id=" + table_id! + "&api_token=$token";

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, headers)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return List<Order>.from(
          json.decode(response).map((x) => Order.fromMap(x)));
    }
  }

  holdCart({String? table_id, String? token}) async {
    var endPoint = "carts-hold?table_id=" + table_id! + "&api_token=" + token!;

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient()
        .get(apiBaseUrl, endPoint, headers)
        .catchError(handelError);

    if (response == null) {
      return;
    } else {
      print(response);
      return;
    }
  }

  changeStatus({
    required cart_id,
    required status,
    String? token,
  }) async {
    var endPoint = "cart-status?id=$cart_id&api_token=$token";
    var body = jsonEncode({
      "status": status,
    });
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await BaseClient().post(apiBaseUrl, endPoint, headers, body);
    if (response == null) {
      return;
    } else {
      print(response);
      return;
    }
  }
}
