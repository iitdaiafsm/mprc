import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mprc/app_drawer/controller.dart';
import 'package:mprc/helper/flutter_bounce.dart';
import 'package:mprc/helper/responsive_widget.dart';

import '../helper/app_config.dart';
import '../helper/styles.dart';
// import '../helper/stylesy_stream_builder.dart';
import 'logic.dart';

class Small extends StatelessWidget {
  final DetailController controller;

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: width(context),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  runAlignment: WrapAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Bounce(
                          onPressed: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(context).dividerColor,
                                  width: 2,
                                )),
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.menu,
                              color: Theme.of(context).dividerColor,
                              size: ResponsiveWidget.isLargeScreen(context)
                                  ? 30
                                  : 15,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.03,
                        ),
                        Text(
                          "Multi Process Robotic Cell",
                          style: textStyle(
                            context: context,
                            isBold: true,
                            fontSize: FontSize.H1,
                          ),
                        ),
                      ],
                    ),
                    GetBuilder<AppDrawerController>(
                      init: AppDrawerController(),
                      builder: (logic) {
                        return Text(
                          logic.userModel.name ?? "",
                          style: textStyle(
                            context: context,
                            isBold: true,
                            fontSize: FontSize.H4,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: textStyle(
                        context: context,
                        fontSize: FontSize.H2,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /*MyStreamBuilder<ProgressModel>(
                      stream: FirebaseHelper.mprcProgress(),
                      builder: (data) {
                        return LinearPercentIndicator(
                          padding: EdgeInsets.zero,
                          percent: (data.overall ?? 0) / 100,
                          fillColor: Theme.of(context).cardColor,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          progressColor: Theme.of(context).dividerColor,
                          barRadius: Radius.circular(100),
                        );
                      },
                    )*/
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: getHeight(AppConfig.DEFAULT_PADDING, context),
              ),
              Container(
                padding: EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                width: width(context),
                /*child: MyStreamBuilder<InventoryModel>(
                  stream: FirebaseHelper.inventoryStream(),
                  builder: (inventory) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Robot Status",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H3,
                          ),
                        ),
                        SizedBox(
                          height:
                              getHeight(AppConfig.DEFAULT_PADDING / 2, context),
                        ),
                        RobotStatusWidget(
                          currentStatus: inventory.robotStatus ?? "error",
                        ),
                        Text(
                          "Tool Changer Engaged",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H3,
                          ),
                        ),
                        SizedBox(
                          height:
                              getHeight(AppConfig.DEFAULT_PADDING / 2, context),
                        ),
                        ToolChangerEngagedWidget(
                          currentStatus:
                              inventory.toolChanger ?? "screw_driver",
                        ),
                        */ /*Text(
                          "Text1",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H5,
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                        Text(
                          "Text1",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H5,
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                        Text(
                          "Text1",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H5,
                          ),
                        ),
                        Divider(
                          color: Theme.of(context).dividerColor,
                        ),
                        Text(
                          "Text1",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H5,
                          ),
                        ),*/ /*
                        SizedBox(
                          height:
                              getHeight(AppConfig.DEFAULT_PADDING / 2, context),
                        ),
                        Text(
                          "Inventory",
                          style: textStyle(
                            context: context,
                            fontSize: FontSize.H3,
                          ),
                        ),
                        SizedBox(
                          height:
                              getHeight(AppConfig.DEFAULT_PADDING / 2, context),
                        ),
                        Wrap(
                          children: [
                            InventoryWidget(
                                title: "Tray 1",
                                inventory: inventory.tray1 ?? 0),
                            InventoryWidget(
                                title: "Tray 2",
                                inventory: inventory.tray2 ?? 0),
                            InventoryWidget(
                                title: "Tray 3",
                                inventory: inventory.tray3 ?? 0),
                            InventoryWidget(
                                title: "Tray 4",
                                inventory: inventory.tray4 ?? 0),
                          ],
                        )
                      ],
                    );
                  },
                ),*/
              ),
              /*SizedBox(
                height: getHeight(AppConfig.DEFAULT_PADDING, context),
              ),
              Container(
                padding: EdgeInsets.all(
                  10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                width: width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Operations",
                      style: textStyle(
                        context: context,
                        fontSize: FontSize.H3,
                      ),
                    ),
                    SizedBox(
                      height: getHeight(AppConfig.DEFAULT_PADDING / 2, context),
                    ),
                    SizedBox(
                      width: width(context),
                      child: Wrap(
                        runSpacing: 10,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.spaceBetween,
                        children: [
                          OperationsCard(
                            title: "Conveyor Station",
                            station: Station.Conveyoy,
                            valuesList: AppConfig.ConveyorOperations,
                          ),
                          OperationsCard(
                            title: "Assembly Station",
                            station: Station.Assembly,
                            valuesList: AppConfig.AssemblyOperations,
                          ),
                          OperationsCard(
                            title: "Testing Station",
                            station: Station.Testing,
                            valuesList: AppConfig.TestingOperations,
                          ),
                          OperationsCard(
                            title: "Packaging Station",
                            station: Station.Packaging,
                            valuesList: AppConfig.PackagingOperations,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
