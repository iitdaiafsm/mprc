import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'logic.dart';
import 'small.dart';

class OrdersListPage extends StatelessWidget {
  OrdersListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersListController>(
      init: OrdersListController(),
      builder: (controller) {
        return ResponsiveWidget(
          smallScreen: Small(
            controller: controller,
          ),
        );
      },
    );
  }
}
