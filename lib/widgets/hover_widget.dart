import 'package:flutter/material.dart';
import 'package:mprc/helper/styles.dart';

class HoverWidget extends StatelessWidget {
  final String filePath;
  final String title;
  final String description;

  const HoverWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.filePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // height: 400,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: Theme.of(context).dividerColor, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  filePath,
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Text(
              title,
              style: textStyle(
                context: context,
                fontSize: FontSize.H3,
                isBold: true,
              ),
            ),
            Text(
              description,
              // maxLines: 3,
              // overflow: TextOverflow.ellipsis,
              style: textStyle(
                context: context,
                fontSize: FontSize.H5,
                isBold: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
