import 'package:get/get.dart';
import 'package:startupapplication/views/admin/card/views/card_details_view.dart';
import 'package:startupapplication/views/blankScreen.dart';
import 'package:startupapplication/welcomePage.dart';

import '../views/admin/card/bindings/card_binding.dart';
import '../views/admin/card/views/card_view.dart';
import '../views/bar/bar_order/bindings/bar_order_binding.dart';
import '../views/bar/bar_order/views/bar_order_view.dart';
import '../views/homePage.dart';
import '../views/kitchen/kitchen_order/bindings/kitchen_order_binding.dart';
import '../views/kitchen/kitchen_order/views/kitchen_order_view.dart';
import '../views/login/bindings/login_binding.dart';
import '../views/login/views/login_view.dart';
import '../views/splash_screen.dart';
import '../views/waiter/menu/bindings/menu_binding.dart';
import '../views/waiter/menu/views/menu_view.dart';
import '../views/waiter/order/bindings/order_binding.dart';
import '../views/waiter/order/views/order_view.dart';
import '../views/waiter/table/bindings/table_binding.dart';
import '../views/waiter/table/views/table_view.dart';
import '../views/waiter/waiter_order/bindings/waiter_order_binding.dart';
import '../views/waiter/waiter_order/views/waiter_order_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.BLANK;

  static final routes = [
    GetPage(
      name: _Paths.BLANK,
      page: () => BlankScreen(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: _Paths.TABLE,
      page: () => TableView(),
      binding: TableBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.KITCHEN_ORDER,
      page: () => KitchenOrderView(),
      binding: KitchenOrderBinding(),
    ),
    GetPage(
      name: _Paths.BAR_ORDER,
      page: () => BarOrderView(),
      binding: BarOrderBinding(),
    ),
    GetPage(
      name: _Paths.WAITER_ORDER,
      page: () => WaiterOrderView(),
      binding: WaiterOrderBinding(),
    ),
    GetPage(
      name: _Paths.CARD,
      page: () => CardView(),
      binding: CardBinding(),
    ),
    GetPage(
      name: _Paths.CARD_DETAILS,
      page: () => CardDetailsView(),
      binding: CardBinding(),
    ),
  ];
}
