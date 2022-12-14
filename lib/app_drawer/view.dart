import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mprc/app_drawer/controller.dart';
import 'package:mprc/helper/flutter_bounce.dart';
import 'package:mprc/helper/responsive_widget.dart';
import 'package:mprc/helper/routes.dart';
import 'package:mprc/helper/theme_controller.dart';
import 'package:mprc/widgets/button.dart';

import '../helper/styles.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) *
          (ResponsiveWidget.isSmallScreen(context)
              ? 0.6
              : ResponsiveWidget.isMediumScreen(context)
                  ? 0.5
                  : 0.3),
      height: height(context),
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: GetBuilder<AppDrawerController>(
          init: AppDrawerController(),
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            logic.userModel.name ?? "",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.H3,
                              isBold: true,
                            ),
                          ),
                          Text(
                            logic.userModel.email ?? "",
                            style: textStyle(
                              context: context,
                              fontSize: FontSize.H5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                GetBuilder<ThemeController>(
                  init: ThemeController(),
                  builder: (controller) {
                    return Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: getHeight(0.6, context)),
                            child: Text(
                              'Light Mode',
                              style: textStyle(
                                context: context,
                              ),
                            ),
                          ),
                        ),
                        Switch(
                          value: controller.isLightTheme,
                          onChanged: controller.setTheme,
                        ),
                      ],
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Bounce(
                  onPressed: () {
                    Get.toNamed(Routes.ORDERS_LIST_PAGE);
                  },
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: getHeight(6, context)),
                          child: Text(
                            'Recent Orders',
                            style: textStyle(
                              context: context,
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                Expanded(child: Container()),
                AppButton(
                  text: "Logout",
                  onTap: logic.logout,
                  padding: 10,
                ),
                // _getDrawerWidget("Conveyor Station",context)
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getDrawerWidget(String title, BuildContext context) {
    return MouseRegion(
      onHover: (event) {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
      ),
    );
  }
}
