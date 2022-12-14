import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/responsive_widget.dart';
import 'logic.dart';
import 'small.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
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
