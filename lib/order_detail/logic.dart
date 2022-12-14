import 'package:get/get.dart';

import '../helper/date_format_helper.dart';

class OrderDetailController extends GetxController {
  Map<String, dynamic> valueMap = <String, dynamic>{};
  Map<String, dynamic> keysValueList = {
    "conveyor_step_1": "Tray present",
    "conveyor_step_2": "Conveyor started",
    "conveyor_step_3": "Stopper down",
    "conveyor_step_4": "Tray identified(RFID)",
    "conveyor_step_5": "Tray at the pickup point",
    "conveyor_step_6": "Conveyor stopped",
    "assembly_step_1": "Part picked from the tray",
    "assembly_step_2": "Part placed between clamping cylinders",
    "assembly_step_3": "Base Part clamped",
    "assembly_step_4": "Inspection done",
    "assembly_step_5": "First part placed",
    "assembly_step_6": "Second part placed",
    "assembly_step_7": "Screwing the parts",
    "assembly_step_8": "Screwing done",
    "testing_step_1": "Part placed",
    "testing_step_2": "Part clamped",
    "testing_step_3": "Testing cylinders extended",
    "testing_step_4": "Pneumatics On",
    "testing_step_5": "Part ok/Not ok",
    "testing_step_6": "Pneumatics off",
    "packaging_step_1": "Part placed in the box",
    "packaging_step_2": "Box picked by the robot",
    "packaging_step_3": "Box flaps closed",
    "packaging_step_4": "Taping done",
    "packaging_step_5": "Printing done",
  };
  List<String> keysList = [];
  String orderId = "";
  @override
  void onInit() {
    valueMap = Get.arguments["value"];
    orderId = Get.arguments["key"];
    keysList = valueMap.keys.toList();
    keysList.sort((first, second) => (valueMap[first] != ""
            ? DateTime.parse(valueMap[first])
            : DateTime.now())
        .compareTo(valueMap[second] != ""
            ? DateTime.parse(valueMap[second])
            : DateTime.now()));
    super.onInit();
  }

  getPercentValue() {
    List<Map<String, dynamic>> operationsList = [];

    for (var item in valueMap.keys) {
      operationsList.add({item: valueMap[item]});
    }
    var emptyValue =
        operationsList.where((element) => element.containsValue("")).length;
    return (operationsList.length - emptyValue) / operationsList.length;
  }

  String getTime(String key) {
    if (valueMap[key] != null && valueMap[key] != "") {
      DateTime dateTime = DateTime.parse(valueMap[key]);
      return DateFormatHelper.convertDateFromDate(dateTime, "hh:mm:ss a");
    } else {
      return "";
    }
  }

  String getOrderTime() {
    var datetimeStr = orderId.replaceAll("OrderID", "");
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(datetimeStr));
    return 'Estimated finish time : ${DateFormatHelper.convertDateFromDate(dateTime, "yyyy-MM-dd hh:mm:ss a")}';
  }
}
