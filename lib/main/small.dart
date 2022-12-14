import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mprc/helper/enums.dart';
import 'package:mprc/widgets/fsm_banner.dart';
import 'package:mprc/widgets/hover_widget.dart';

import '../helper/app_config.dart';
import '../helper/colors.dart';
import '../helper/firebase_helper.dart';
import '../helper/flutter_bounce.dart';
import '../helper/models/inventory_model.dart';
import '../helper/models/progress_model.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';
import '../widgets/inventory_widget.dart';
import '../widgets/linear_percent_indicator.dart';
import '../widgets/my_stream_builder.dart';
import '../widgets/process_cards.dart';
import '../widgets/robot_status_widget.dart';
import '../widgets/tool_changer_engaged.dart';
import 'logic.dart';

class Small extends StatelessWidget {
  final MainController controller;
  GlobalKey<ScaffoldState> drawerKey;

  Small({Key? key, required this.controller, required this.drawerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: width(context),
                        child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.end,
                          children: [
                            Container(
                              width: width(context) * 0.2,
                              alignment: Alignment.centerLeft,
                              child: Bounce(
                                onPressed: () {
                                  drawerKey.currentState?.openDrawer();
                                },
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
                                    size:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? 30
                                            : 15,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Multi Process Robotic Cell",
                              style: textStyle(
                                context: context,
                                isBold: true,
                                fontSize: FontSize.H1,
                              ),
                            ),
                            /*GetBuilder<AppDrawerController>(
                              init: AppDrawerController(),
                              builder: (logic) {
                                return Container(
                                  width: width(context) * 0.2,
                                  alignment: Alignment.centerRight,
                                  child: ResponsiveWidget.isSmallScreen(context)
                                      ? Opacity(
                                          opacity: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    Theme.of(context).cardColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .dividerColor,
                                                  width: 2,
                                                )),
                                            padding: EdgeInsets.all(10),
                                            child: Icon(
                                              Icons.menu,
                                              color: Theme.of(context)
                                                  .dividerColor,
                                              size: ResponsiveWidget
                                                      .isLargeScreen(context)
                                                  ? 30
                                                  : 15,
                                            ),
                                          ),
                                        )
                                      : FittedBox(
                                          child: Text(
                                            logic.userModel.name ?? "",
                                            // "HHHHHHHHHHHHHHHHHHHHHHHHHH",
                                            style: textStyle(
                                              context: context,
                                              isBold: true,
                                              // fontSize: FontSize.H4,
                                            ),
                                          ),
                                        ),
                                );
                              },
                            ),*/
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyStreamBuilder<ProgressModel>(
                                  stream: FirebaseHelper.mprcProgress(),
                                  builder: (data) {
                                    return Text(
                                      "Progress (${(data.overall ?? 0).toStringAsFixed(2)})%",
                                      style: textStyle(
                                        context: context,
                                        fontSize: FontSize.H2,
                                      ),
                                    );
                                  },
                                ),
                                MyStreamBuilder<InventoryModel>(
                                    stream: FirebaseHelper.inventoryStream(),
                                    builder: (inventoryModel) {
                                      /*Get.log(
                                          "Inventory : ${jsonEncode(inventoryModel)}");*/
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              (inventoryModel.powerStatus == 1)
                                                  ? appPreviousColor
                                                  : appNextColor,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 5),
                                        child: Text(
                                          "MPRC ${(inventoryModel.powerStatus == 1) ? 'On' : 'Off'}",
                                          style: textStyle(
                                            context: context,
                                            isBold: true,
                                            color: Colors.white,
                                            fontSize: FontSize.H3,
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MyStreamBuilder<ProgressModel>(
                                stream: FirebaseHelper.mprcProgress(),
                                builder: (progressModel) {
                                  return LinearPercentIndicator(
                                    padding: EdgeInsets.zero,
                                    percent:
                                        ((progressModel.overall ?? 0) / 100),
                                    fillColor: Theme.of(context).cardColor,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    progressColor:
                                        Theme.of(context).dividerColor,
                                    barRadius: Radius.circular(100),
                                  );
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width(context),
                        child: Wrap(
                          runSpacing: 10,
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            ProcessCards(
                              title: "Conveyor Station",
                              valuesList: AppConfig.ConveyorOperations,
                              station: Station.Conveyoy,
                              content: const HoverWidget(
                                  title: "Conveyor Station",
                                  description:
                                      "Use to transfer the inventory tray or pallet to the place where robot can pick them.",
                                  filePath: "asset/conveyor_station.png"),
                            ),
                            ProcessCards(
                              title: "Assembly Station",
                              station: Station.Assembly,
                              valuesList: AppConfig.AssemblyOperations,
                              content: const HoverWidget(
                                  title: "Assembly Station",
                                  description:
                                      "All the parts (Axisymmetric and prismatic parts) will be assembled and screwed on the valve body in this station. Along with that inventory scanning and vision inspection of the valve bodies will be done in this station.",
                                  filePath: "asset/assembly_station.png"),
                            ),
                            /*ProcessCards(
                              title: "Testing Station",
                              station: Station.Testing,
                              valuesList: AppConfig.TestingOperations,
                              content: const HoverWidget(
                                  title: "Testing Station",
                                  description:
                                      "All the ports of the valve body will be tested in this station. If there is any leakage, valve body will be rejected.",
                                  filePath: "asset/testing_station.png"),
                            ),*/
                            /*ProcessCards(
                          title: "Hexnut Station",
                          percentValue: 0,
                          valuesList: [
                            ValueData("Text1", ValueType.CheckBox, false),
                            ValueData("Text2", ValueType.CheckBox, false),
                            ValueData("Text3", ValueType.CheckBox, false),
                          ],
                        ),*/
                            ProcessCards(
                              title: "Packaging Station",
                              station: Station.Packaging,
                              valuesList: AppConfig.PackagingOperations,
                              content: const HoverWidget(
                                  title: "Packaging Station",
                                  description:
                                      "Assembled valve bodies will be placed in a box and packaging is done. A printing head will print the required details( Type of bodies ,number of bodies, date of assembly etc…)  on the box and then the box will be dispatched.",
                                  filePath: "asset/packaging_station.png"),
                            ),
                          ],
                        ),
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
                        child: MyStreamBuilder<InventoryModel>(
                            stream: FirebaseHelper.inventoryStream(),
                            builder: (inventory) {
                              return Wrap(
                                runSpacing: 10,
                                alignment: WrapAlignment.spaceBetween,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Robot Status",
                                        style: textStyle(
                                          context: context,
                                          fontSize: FontSize.H3,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(
                                            AppConfig.DEFAULT_PADDING / 2,
                                            context),
                                      ),
                                      RobotStatusWidget(
                                        currentStatus:
                                            inventory.robotStatus ?? "error",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tool Changer Engaged",
                                        style: textStyle(
                                          context: context,
                                          fontSize: FontSize.H3,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getHeight(
                                            AppConfig.DEFAULT_PADDING / 2,
                                            context),
                                      ),
                                      ToolChangerEngagedWidget(
                                        currentStatus: inventory.toolChanger ??
                                            "screw_driver",
                                      ),
                                    ],
                                  ),
                                  /*Text(
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
                                  ),*/
                                  if (inventory.tray1 != null ||
                                      inventory.tray2 != null ||
                                      inventory.tray3 != null ||
                                      inventory.tray4 != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Inventory",
                                          style: textStyle(
                                            context: context,
                                            fontSize: FontSize.H3,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getHeight(
                                              AppConfig.DEFAULT_PADDING / 2,
                                              context),
                                        ),
                                        if (inventory.tray1 != null ||
                                            inventory.tray2 != null ||
                                            inventory.tray3 != null ||
                                            inventory.tray4 != null)
                                          Wrap(
                                            children: [
                                              if (inventory.tray1 != null)
                                                InventoryWidget(
                                                    title: "Tray 1",
                                                    inventory:
                                                        inventory.tray1 ?? 0),
                                              if (inventory.tray2 != null)
                                                InventoryWidget(
                                                    title: "Tray 2",
                                                    inventory:
                                                        inventory.tray2 ?? 0),
                                              if (inventory.tray3 != null)
                                                InventoryWidget(
                                                    title: "Tray 3",
                                                    inventory:
                                                        inventory.tray3 ?? 0),
                                              if (inventory.tray4 != null)
                                                InventoryWidget(
                                                    title: "Tray 4",
                                                    inventory:
                                                        inventory.tray4 ?? 0),
                                            ],
                                          ),
                                      ],
                                    )
                                ],
                              );
                            }),
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
            ),
            FSMBanner(),
          ],
        ),
      ),
    );
  }
}
