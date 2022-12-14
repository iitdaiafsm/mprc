import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'logic.dart';
import 'small.dart';

class OrderDetailPage extends StatelessWidget {
  OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailController>(
      init: OrderDetailController(),
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
