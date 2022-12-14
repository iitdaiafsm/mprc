import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../helper/flutter_bounce.dart';
import '../helper/responsive_widget.dart';
import '../helper/styles.dart';

class AppButton extends StatelessWidget {
  void Function()? onTap;
  String text;
  bool isLoading;
  double? padding;
  IconData? icon;
  Color? backgroundColor;
  Color? textColor;
  bool haveMargin;
  AppButton({
    Key? key,
    this.onTap,
    this.text = "Button",
    this.icon,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
    this.haveMargin = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bounce(
          onPressed: () {
            if (Get.focusScope!.hasFocus) {
              Get.focusScope!.unfocus();
            }
            onTap!();
          },
          child: Container(
            margin: haveMargin
                ? EdgeInsets.only(bottom: getHeight(15, context))
                : null,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  getWidth(1000, context),
                ),
                color: backgroundColor ?? Theme.of(context).primaryColorLight),
            child: Padding(
              padding: EdgeInsets.all(padding ?? 20),
              child: Center(
                child: isLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: textColor ?? Colors.white,
                        size: getWidth(9, context) *
                            (ResponsiveWidget.isLargeScreen(context)
                                ? 1
                                : ResponsiveWidget.isMediumScreen(context)
                                    ? 2
                                    : 3),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            text,
                            style: textStyle(
                              context: context,
                              color: textColor ?? Colors.white,
                              fontSize: FontSize.H3,
                              isBold: true,
                            ),
                          ),
                          if (icon != null)
                            Padding(
                              padding: EdgeInsets.only(
                                left: getWidth(30, context),
                              ),
                              child: Icon(
                                icon,
                                size: getWidth(60, context),
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
