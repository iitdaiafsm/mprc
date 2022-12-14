import 'package:get/get.dart';
import 'package:mprc/detail/view.dart';
import 'package:mprc/login/view.dart';
import 'package:mprc/main/view.dart';
import 'package:mprc/orders_list/view.dart';

import '../order_detail/view.dart';

class Routes {
  static const INITIAL_ROUTE = "/";
  static const DASHBOARD_PAGE = "/main-page";
  static const DETAIL_PAGE = "/detail-page";
  static const ORDERS_LIST_PAGE = "/orders-list";
  static const ORDER_DETAIL_PAGE = "/order-detail";
  static final routes = [
    GetPage(name: INITIAL_ROUTE, page: () => LoginPage()),
    GetPage(name: DASHBOARD_PAGE, page: () => MainPage()),
    GetPage(name: DETAIL_PAGE, page: () => DetailPage()),
    GetPage(name: ORDERS_LIST_PAGE, page: () => OrdersListPage()),
    GetPage(name: ORDER_DETAIL_PAGE, page: () => OrderDetailPage()),
  ];
}
