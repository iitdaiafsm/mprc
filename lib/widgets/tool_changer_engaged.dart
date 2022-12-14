import 'package:flutter/material.dart';

import '../helper/styles.dart';

class ToolChangerEngagedWidget extends StatelessWidget {
  final List<Map<String, String>> statusList = [
    {"key": "screw_driver", "value": "Gripper with Screwdriver"},
    {"key": "vacuum", "value": "Vacuum type Gripper"},
    {"key": "qr_code", "value": "QR Code Scanner"},
  ];
  final String currentStatus;

  ToolChangerEngagedWidget({Key? key, required this.currentStatus})
      : super(key: key);

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
            color: statusList[index]["key"] == currentStatus
                ? Theme.of(context).dividerColor
                : Theme.of(context).cardColor,
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            statusList[index]["value"]!,
            style: textStyle(
              context: context,
              isBold: statusList[index]["key"] == currentStatus,
              fontSize: FontSize.H5,
            ),
          ),
        ),
      ),
    );
  }
}
