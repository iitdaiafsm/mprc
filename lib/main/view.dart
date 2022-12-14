import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_drawer/view.dart';
import '../helper/responsive_widget.dart';
import 'logic.dart';
import 'small.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) {
        return Scaffold(
          drawer: AppDrawer(),
          key: _key,
          body: ResponsiveWidget(
            smallScreen: Small(
              controller: controller,
              drawerKey: _key,
            ),
          ),
        );
      },
    );
  }
}
