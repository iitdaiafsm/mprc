import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'logic.dart';
import 'small.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
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
