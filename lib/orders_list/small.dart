import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mprc/helper/flutter_bounce.dart';
import 'package:mprc/widgets/fsm_banner.dart';

import '../helper/responsive_widget.dart';
import '../helper/styles.dart';
import 'logic.dart';

class Small extends StatelessWidget {
  final OrdersListController controller;

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
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Orders",
                        style: textStyle(
                          context: context,
                          isBold: true,
                          fontSize: FontSize.H1,
                        ),
                      ),
                    ),
                    /*Wrap(
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: List.generate(
                    controller.valueMap.keys.length,
                    (index) => Container(
                      constraints: BoxConstraints.tightFor(
                          width: ResponsiveWidget.isSmallScreen(context)
                              ? width(context) * 0.42
                              : ResponsiveWidget.isMediumScreen(context)
                                  ? width(context) * 0.45
                                  : width(context) * 0.24),
                      padding: EdgeInsets.all(
                        ResponsiveWidget.isSmallScreen(context)
                            ? width(context) * 0.02
                            : ResponsiveWidget.isMediumScreen(context)
                                ? width(context) * 0.01
                                : width(context) * 0.007,
                      ),
                      margin: EdgeInsets.all(
                        ResponsiveWidget.isSmallScreen(context)
                            ? width(context) * 0.007
                            : ResponsiveWidget.isMediumScreen(context)
                                ? width(context) * 0.005
                                : width(context) * 0.001,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(
                            10,
                          ),
                          topLeft: Radius.circular(
                            10,
                          ),
                          bottomLeft: Radius.circular(
                            10,
                          ),
                          bottomRight: Radius.circular(
                            10,
                          ),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: _getShadowColor(),
                        //     offset: const Offset(0, 0),
                        //     blurRadius: getWidth(1, context),
                        //   )
                        // ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.valueMap.keys.toList()[index],
                            style: textStyle(context: context),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          LinearPercentIndicator(
                            padding: EdgeInsets.zero,
                            percent: controller.getPercentValue(
                                controller.valueMap.keys.toList()[index]),
                            fillColor: Theme.of(context).cardColor,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            progressColor: Theme.of(context).dividerColor,
                            barRadius: Radius.circular(100),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                controller.getTime(
                                    controller.valueMap.keys.toList()[index]),
                                style: textStyle(context: context),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/
                    Container(
                      padding: EdgeInsets.all(
                        ResponsiveWidget.isSmallScreen(context)
                            ? width(context) * 0.02
                            : ResponsiveWidget.isMediumScreen(context)
                                ? width(context) * 0.01
                                : width(context) * 0.007,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(
                            10,
                          ),
                          topLeft: Radius.circular(
                            10,
                          ),
                          bottomLeft: Radius.circular(
                            10,
                          ),
                          bottomRight: Radius.circular(
                            10,
                          ),
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: _getShadowColor(),
                        //     offset: const Offset(0, 0),
                        //     blurRadius: getWidth(1, context),
                        //   )
                        // ],
                      ),
                      child: Column(
                        children: List.generate(
                            controller.valueMap.keys.length,
                            (index) => Column(
                                  children: [
                                    Bounce(
                                      onPressed: () {
                                        controller.navigateToOrderDetail(
                                            controller.valueMap.keys
                                                .toList()[index]);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            controller.valueMap.keys
                                                .toList()[index],
                                            style: textStyle(
                                              context: context,
                                              fontSize: FontSize.H2,
                                              isBold: true,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            controller.getTime(controller
                                                .valueMap.keys
                                                .toList()[index]),
                                            style: textStyle(
                                              context: context,
                                              fontSize: FontSize.H5,
                                              isItalic: true,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (index !=
                                        controller.valueMap.keys.length - 1)
                                      Container(
                                        width: double.infinity,
                                        height: 1,
                                        color: Theme.of(context).primaryColor,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                      ),
                                  ],
                                )),
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
