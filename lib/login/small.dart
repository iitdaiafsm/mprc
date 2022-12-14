import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mprc/helper/responsive_widget.dart';
import 'package:mprc/widgets/button.dart';
import 'package:mprc/widgets/fsm_banner.dart';

import '../helper/styles.dart';
import 'logic.dart';

class Small extends StatelessWidget {
  final LoginController controller;

  Small({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: width(context),
        height: height(context),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Multi Process Robotic Cell",
                      style: textStyle(
                        context: context,
                        isBold: true,
                        fontSize: FontSize.TITLE,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      constraints: BoxConstraints(
                          maxWidth: width(context) * 0.8,
                          minWidth: width(context) * 0.8,
                          minHeight: height(context) *
                              (ResponsiveWidget.isSmallScreen(context)
                                  ? 0.8
                                  : ResponsiveWidget.isMediumScreen(context)
                                      ? 0.7
                                      : 0.6)),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Wrap(
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            if (!ResponsiveWidget.isLargeScreen(context))
                              Text(
                                "Login",
                                style: textStyle(
                                  context: context,
                                  fontSize: FontSize.TITLE,
                                  isBold: true,
                                ),
                              ),
                            Lottie.asset(
                              "asset/login.json",
                              width: width(context) *
                                  (ResponsiveWidget.isSmallScreen(context)
                                      ? 0.8
                                      : ResponsiveWidget.isMediumScreen(context)
                                          ? 0.7
                                          : 0.3),
                            ),
                            Column(
                              children: [
                                if (ResponsiveWidget.isLargeScreen(context))
                                  Text(
                                    "Login",
                                    style: textStyle(
                                      context: context,
                                      fontSize: FontSize.TITLE,
                                      isBold: true,
                                    ),
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Start journey with us",
                                  style: textStyle(
                                      context: context,
                                      fontSize: FontSize.H1,
                                      isBold: false,
                                      isItalic: true),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: ResponsiveWidget.isLargeScreen(context)
                                      ? width(context) * 0.3
                                      : width(context),
                                  child: AppButton(
                                    onTap: controller.googleSignIn,
                                    padding: 15,
                                    isLoading: controller.isLoading,
                                    text: "Login with Google",
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Text(
                        "Multi Process Robotic Cell",
                        style: textStyle(
                          context: context,
                          isBold: true,
                          fontSize: FontSize.TITLE,
                        ),
                      ),
                    ),
                  ],
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
