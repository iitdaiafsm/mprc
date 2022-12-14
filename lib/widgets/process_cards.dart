import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:mprc/helper/models/progress_model.dart';
import 'package:mprc/helper/responsive_widget.dart';
import 'package:mprc/helper/styles.dart';

import '../helper/colors.dart';
import '../helper/date_format_helper.dart';
import '../helper/enums.dart';
import '../helper/firebase_helper.dart';
import 'circular_percent_indicator.dart';
import 'linear_percent_indicator.dart';
import 'my_stream_builder.dart';
// import '../helper/enumseam_builder.dart';

class ProcessCards extends StatelessWidget {
  final String title;
  final Widget content;
  final Station station;
  final List<Map<String, dynamic>> valuesList;
  final JustTheController controller = JustTheController();

  ProcessCards({
    Key? key,
    required this.title,
    required this.content,
    required this.station,
    required this.valuesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(
          width: ResponsiveWidget.isSmallScreen(context)
              ? width(context) * 0.45
              : ResponsiveWidget.isMediumScreen(context)
                  ? width(context) * 0.48
                  : width(context) * 0.24),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(getWidth(1, context)),
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
            /*constraints: BoxConstraints(
                  maxWidth: 450,
                  minWidth: 250,
                ),*/

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    10,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textStyle(
                            context: context,
                            color: Theme.of(context).primaryColor,
                            isBold: true,
                            fontSize: FontSize.H4),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MyStreamBuilder<ProgressModel>(
                          stream: FirebaseHelper.mprcProgress(),
                          builder: (progressModel) {
                            double percentValue =
                                _getPercentageValue(progressModel);
                            return ResponsiveWidget.isLargeScreen(context)
                                ? CircularPercentIndicator(
                                    radius: 50,
                                    percent: percentValue,
                                    fillColor: Theme.of(context).cardColor,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    animation: true,
                                    progressColor:
                                        _getShadowColor(percentValue),
                                    animateFromLastPercent: true,
                                    lineWidth: 13,
                                    circularStrokeCap: CircularStrokeCap.round,
                                    center: Text(
                                      "${(percentValue * 100).toStringAsFixed(1)}%",
                                      style: textStyle(
                                        context: context,
                                        color: _getShadowColor(percentValue),
                                        isBold: true,
                                        fontSize: FontSize.H4,
                                      ),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Expanded(
                                        child: LinearPercentIndicator(
                                          padding: EdgeInsets.zero,
                                          percent: percentValue,
                                          fillColor:
                                              Theme.of(context).cardColor,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          progressColor:
                                              _getShadowColor(percentValue),
                                          barRadius: Radius.circular(100),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        "${(percentValue * 100).toStringAsFixed(1)}%",
                                        style: textStyle(
                                          context: context,
                                          color: _getShadowColor(percentValue),
                                          isBold: true,
                                          fontSize: FontSize.H4,
                                        ),
                                      )
                                    ],
                                  );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      if (!ResponsiveWidget.isLargeScreen(context))
                        Container(
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
                            // border: Border.all(color: Theme.of(context).dividerColor)
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: _getShadowColor(),
                            //     offset: const Offset(0, 0),
                            //     blurRadius: getWidth(1, context),
                            //   )
                            // ],
                          ),
                          /*constraints: BoxConstraints(
              maxWidth: 450,
              minWidth: 250,
            ),*/
                          constraints: BoxConstraints.tightFor(
                              height: height(context) *
                                  (ResponsiveWidget.isLargeScreen(context)
                                      ? 1
                                      : ResponsiveWidget.isMediumScreen(context)
                                          ? 0.2
                                          : 0.2)),
                          child: _getOperationsWidget(context),
                        )
                    ],
                  ),
                ),
                MyStreamBuilder<ProgressModel>(
                    stream: FirebaseHelper.mprcProgress(),
                    builder: (progressModel) {
                      double percentValue = _getPercentageValue(progressModel);
                      return Container(
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(
                              10,
                            ),
                            bottomRight: Radius.circular(
                              10,
                            ),
                          ),
                          color: _getShadowColor(percentValue),
                        ),
                      );
                    })
              ],
            ),
          ),
          if (ResponsiveWidget.isLargeScreen(context))
            Container(
              margin: EdgeInsets.only(top: 5),
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
                // border: Border.all(color: Theme.of(context).dividerColor)
                // boxShadow: [
                //   BoxShadow(
                //     color: _getShadowColor(),
                //     offset: const Offset(0, 0),
                //     blurRadius: getWidth(1, context),
                //   )
                // ],
              ),
              /*constraints: BoxConstraints(
              maxWidth: 450,
              minWidth: 250,
            ),*/
              height: height(context) * 0.2,
              child: Padding(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: _getOperationsWidget(context),
              ),
            )
        ],
      ),
    );
  }

  _getTrailingWidget(ValueData values, BuildContext context) {
    if (values.valueType == ValueType.CheckBox && values.value) {
      return Icon(
        Icons.check_box,
        color: Theme.of(context).primaryColor,
      );
    } else if (values.valueType == ValueType.CheckBox && !values.value) {
      return Icon(
        Icons.check_box_outline_blank_outlined,
        color: Theme.of(context).primaryColor,
      );
    } else if (values.valueType == ValueType.TrueFalse && values.value) {
      return Icon(
        Icons.check,
        color: Theme.of(context).primaryColor,
      );
    } else if (values.valueType == ValueType.TrueFalse && !values.value) {
      return Icon(
        Icons.close,
        color: Theme.of(context).primaryColor,
      );
    } else {
      return Container();
    }
  }

  Color _getShadowColor(double percentValue) {
    /*if (percentValue == 0) {
      return appNextColor;
    } else if (percentValue == 1) {
      return appPreviousColor;
    } else {
      return appCurrentColor;
    }*/
    if (percentValue >= 0 && percentValue <= 0.1) {
      return color1;
    } else if (percentValue > 0.1 && percentValue <= 0.2) {
      return color2;
    } else if (percentValue > 0.2 && percentValue <= 0.3) {
      return color3;
    } else if (percentValue > 0.3 && percentValue <= 0.4) {
      return color4;
    } else if (percentValue > 0.4 && percentValue <= 0.5) {
      return color5;
    } else if (percentValue > 0.5 && percentValue <= 0.6) {
      return color6;
    } else if (percentValue > 0.6 && percentValue <= 0.7) {
      return color7;
    } else if (percentValue > 0.7 && percentValue <= 0.8) {
      return color8;
    } else if (percentValue > 0.8 && percentValue <= 0.9) {
      return color9;
    } else {
      return color10;
    }
  }

  List<Color> ranbowColor = [
    Color(0xFFFF2727),
    Color(0xFFFF5128),
    Color(0xFFFF7C29),
    Color(0xFFFFA629),
    Color(0xFFFFD02A),
    Color(0xFFD1C122),
    Color(0xFFA2B219),
    Color(0xFF74A411),
    Color(0xFF459508),
    Color(0xFF178600),
  ];

  Color getProgressColor(double percentValue) {
    //progress is between 0 to 1
    return ranbowColor[(percentValue * 10).round()];
  }

  double _getPercentageValue(ProgressModel progressModel) {
    switch (station) {
      case Station.Conveyoy:
        return (progressModel.conveyorStation ?? 0) / 100;
      case Station.Assembly:
        return (progressModel.assemblyStation ?? 0) / 100;
      /*case Station.Testing:
        return (progressModel.testingStation ?? 0)/100;*/
      case Station.Packaging:
        return (progressModel.packagingStation ?? 0) / 100;
    }
  }

  /*String getCurrentOperation(CurrentOperationModel currentOperation) {
    switch (station) {
      case Station.Conveyoy:
        return "${currentOperation.conveyorStation}";
      case Station.Assembly:
        return "${currentOperation.assemblyStation}";
      case Station.Testing:
        return "${currentOperation.testingStation}";
      case Station.Packaging:
        return "${currentOperation.packagingStation}";
    }
  }*/

  Widget _getOperationsWidget(BuildContext context) {
    return MyStreamBuilder<Map<String, dynamic>>(
        stream: FirebaseHelper.streamOperations(),
        builder: (map) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              valuesList.length,
              (index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  valuesList[index]["key"].toString() ==
                          map["current_operation"]
                      ? Container(
                          width: 15,
                          height: 15,
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  appCurrentColor),
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : Icon(
                          Icons.check_circle,
                          size: 15,
                          color: map["operations"][valuesList[index]["key"]] !=
                                      null &&
                                  map["operations"][valuesList[index]["key"]]
                                      .toString()
                                      .isNotEmpty
                              ? appPreviousColor
                              : Colors.grey,
                        ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Text(
                      valuesList[index]["value"],
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).primaryColor,
                        fontSize: ResponsiveWidget.isLargeScreen(context)
                            ? FontSize.H5
                            : FontSize.H4,
                      ),
                    ),
                  ),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    SizedBox(
                      width: 6,
                    ),
                  if (!ResponsiveWidget.isSmallScreen(context))
                    Text(
                      map["operations"][valuesList[index]["key"]] != null &&
                              map["operations"][valuesList[index]["key"]]
                                  .toString()
                                  .isNotEmpty
                          ? DateFormatHelper.convertDateFromDate(
                              DateTime.parse(map["operations"]
                                      [valuesList[index]["key"]]
                                  .toString()
                                  .toUpperCase()),
                              "hh:mm:ss a")
                          : "",
                      style: textStyle(
                        context: context,
                        color: Theme.of(context).primaryColor,
                        fontSize: ResponsiveWidget.isLargeScreen(context)
                            ? FontSize.H5
                            : FontSize.H5,
                        isBold: true,
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}

enum ValueType {
  Default,
  CheckBox,
  TrueFalse,
}

class ValueData {
  final String text;
  final ValueType valueType;
  final bool value;

  ValueData(this.text, this.valueType, this.value);
}
