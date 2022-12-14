import 'package:flutter/material.dart';
import 'package:mprc/helper/colors.dart';
import 'package:mprc/helper/styles.dart';

class InventoryWidget extends StatelessWidget {
  final String title;
  final int inventory;

  const InventoryWidget(
      {Key? key, required this.title, required this.inventory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: inventory == 0
              ? Colors.red
              : inventory > 0 && inventory < 10
                  ? appCurrentColor
                  : appPreviousColor,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: textStyle(
              context: context,
              fontSize: FontSize.H4,
              isBold: true,
            ),
          ),
          Text(
            "$inventory",
            style: textStyle(
              context: context,
              fontSize: FontSize.H4,
              isBold: false,
            ),
          ),
        ],
      ),
    );
  }
}
