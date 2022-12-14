import 'package:get/get.dart';
import 'package:mprc/helper/date_format_helper.dart';
import 'package:mprc/helper/firebase_helper.dart';

import '../helper/routes.dart';

class OrdersListController extends GetxController {
  Map<String, dynamic> valueMap = <String, dynamic>{};
  @override
  void onInit() {
    readOrders();
    super.onInit();
  }

  Future<void> readOrders() async {
    valueMap = await FirebaseHelper.readOrder();
    update();
  }

  getPercentValue(String key) {
    List<Map<String, dynamic>> operationsList = [];
    var operations = valueMap[key];
    for (var item in operations.keys) {
      operationsList.add({item: operations[item]});
    }
    var emptyValue =
        operationsList.where((element) => element.containsValue("")).length;
    return (operationsList.length - emptyValue) / operationsList.length;
  }

  String getTime(String key) {
    var datetimeStr = key.replaceAll("OrderID", "");
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(datetimeStr));
    return DateFormatHelper.convertDateFromDate(
        dateTime, "dd MMM, yyyy hh:mm:ss a");
  }

  void navigateToOrderDetail(String key) {
    Get.toNamed(Routes.ORDER_DETAIL_PAGE,
        arguments: {"key": key, "value": valueMap[key]});
  }
}
