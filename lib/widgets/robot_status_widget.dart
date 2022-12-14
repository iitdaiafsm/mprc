import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/styles.dart';

class RobotStatusWidget extends StatelessWidget {
  final List<String> statusList = ["idle", "running", "error"];
  final String currentStatus;

  RobotStatusWidget({Key? key, required this.currentStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        statusList.length,
        (index) => Container(
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: statusList[index] == currentStatus
                ? Theme.of(context).dividerColor
                : Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            statusList[index].capitalize ?? "",
            style: textStyle(
              context: context,
              isBold: statusList[index] == currentStatus,
              fontSize: FontSize.H5,
            ),
          ),
        ),
      ),
    );
  }
}
