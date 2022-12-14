import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mprc/helper/models/progress_model.dart';
import 'package:mprc/helper/responsive_widget.dart';
import 'package:mprc/helper/styles.dart';

import '../helper/colors.dart';
import '../helper/enums.dart';

class OperationsCard extends StatelessWidget {
  final String title;
  final Station station;
  final List<Map<String, dynamic>> valuesList;

  OperationsCard({
    Key? key,
    required this.title,
    required this.station,
    required this.valuesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getWidth(1, context)),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
          border: Border.all(color: Theme.of(context).dividerColor)
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
          width: ResponsiveWidget.isSmallScreen(context)
              ? width(context)
              : ResponsiveWidget.isMediumScreen(context)
                  ? width(context)
                  : width(context) * 0.48,
          height: getWidth(120, context) *
              (ResponsiveWidget.isLargeScreen(context)
                  ? 1
                  : ResponsiveWidget.isMediumScreen(context)
                      ? 2
                      : 3)),
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
                SizedBox(
                  height: 10,
                ),
                /*StreamBuilder<CurrentOperationModel>(
                        stream: FirebaseHelper.currentOperationStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            CurrentOperationModel currentOperation =
                                snapshot.requireData;
                            return Text(
                              getCurrentOperation(currentOperation),
                              style: textStyle(
                                context: context,
                                color: Theme.of(context).primaryColor,
                                fontSize: FontSize.H4,
                              ),
                            );
                          } else {
                            return const SizedBox(
                              width: 0,
                              height: 0,
                            );
                          }
                        }),*/
                Column(
                  children: List.generate(
                      valuesList.length,
                      (index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  valuesList[index]["value"],
                                  style: textStyle(
                                    context: context,
                                    color: Theme.of(context).primaryColor,
                                    fontSize:
                                        ResponsiveWidget.isLargeScreen(context)
                                            ? FontSize.H4
                                            : FontSize.H4,
                                  ),
                                ),
                              ),
                            ],
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getShadowColor(double percentValue) {
    if (percentValue == 0) {
      return appNextColor;
    } else if (percentValue == 1) {
      return appPreviousColor;
    } else {
      return appCurrentColor;
    }
  }

  double _getPercentageValue(ProgressModel progressModel) {
    switch (station) {
      case Station.Conveyoy:
        return (progressModel.conveyorStation ?? 0) / 100;
      case Station.Assembly:
        return (progressModel.assemblyStation ?? 0) / 100;
      /*case Station.Testing:
        return (progressModel.testingStation ?? 0) / 100;*/
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
}
