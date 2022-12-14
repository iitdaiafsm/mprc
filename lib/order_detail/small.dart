import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mprc/helper/colors.dart';
import 'package:mprc/helper/flutter_bounce.dart';
import 'package:mprc/helper/responsive_widget.dart';
import 'package:mprc/widgets/dotted_line.dart';

import '../helper/styles.dart';
import '../widgets/fsm_banner.dart';
import '../widgets/linear_percent_indicator.dart';
import 'logic.dart';

class Small extends StatelessWidget {
  final OrderDetailController controller;

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    SizedBox(
                      width: ResponsiveWidget.isLargeScreen(context)
                          ? width(context) * 0.4
                          : width(context) - 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.orderId,
                                style: textStyle(
                                  context: context,
                                  // isBold: true,
                                  fontSize: FontSize.H1,
                                ),
                              ),
                              !ResponsiveWidget.isLargeScreen(context)
                                  ? Bounce(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.getOrderTime(),
                            style: textStyle(
                              context: context,
                              // isBold: true,
                              fontSize: FontSize.H3,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  percent: controller.getPercentValue(),
                                  fillColor: Theme.of(context).cardColor,
                                  backgroundColor: Theme.of(context).cardColor,
                                  progressColor: Theme.of(context).dividerColor,
                                  barRadius: Radius.circular(100),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${controller.getPercentValue() * 100}%",
                                style: textStyle(
                                  context: context,
                                  isBold: true,
                                  fontSize: FontSize.H1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            controller.keysList.length,
                            (index) => Bounce(
                              onPressed: () {
                                // controller.navigateToOrderDetail(controller.valueMap.keys.toList()[index]);
                              },
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: index == 0
                                              ? Container(
                                                  width: 1,
                                                )
                                              : DottedLine(
                                                  direction: Axis.vertical,
                                                  lineLength: double.infinity,
                                                  lineThickness: 1.0,
                                                  dashLength: 4.0,
                                                  dashColor: Theme.of(context)
                                                      .primaryColor,
                                                  // dashGradient: [Colors.red, Colors.blue],
                                                  dashRadius: 0.0,
                                                  dashGapLength: 4.0,
                                                  dashGapColor:
                                                      Colors.transparent,
                                                  /*dashGapGradient: [
                                                    Colors.red,
                                                    Colors.blue
                                                  ],*/
                                                  dashGapRadius: 0.0,
                                                ),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: controller
                                                      .getTime(controller
                                                          .keysList[index])
                                                      .isNotEmpty
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : appNextColor,
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            controller
                                                    .getTime(controller
                                                        .keysList[index])
                                                    .isNotEmpty
                                                ? Icons.check
                                                : Icons.close,
                                            color: controller
                                                    .getTime(controller
                                                        .keysList[index])
                                                    .isNotEmpty
                                                ? Theme.of(context).primaryColor
                                                : appNextColor,
                                            size: 10,
                                          ),
                                        ),
                                        Expanded(
                                          child: index ==
                                                  controller.keysList.length - 1
                                              ? Container()
                                              : DottedLine(
                                                  direction: Axis.vertical,
                                                  lineLength: double.infinity,
                                                  lineThickness: 1.0,
                                                  dashLength: 4.0,
                                                  dashColor: Theme.of(context)
                                                      .primaryColor,
                                                  // dashGradient: [Colors.red, Colors.blue],
                                                  dashRadius: 0.0,
                                                  dashGapLength: 4.0,
                                                  dashGapColor:
                                                      Colors.transparent,
                                                  /*dashGapGradient: [
                                                    Colors.red,
                                                    Colors.blue
                                                  ],*/
                                                  dashGapRadius: 0.0,
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    controller.keysValueList[
                                        controller.keysList[index]],
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H4,
                                      // isBold: true,
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Text(
                                    controller
                                        .getTime(controller.keysList[index]),
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H5,
                                      isItalic: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topRight,
                        child: ResponsiveWidget.isLargeScreen(context)
                            ? Bounce(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          FSMBanner(),
        ],
      ),
    );
  }
}
