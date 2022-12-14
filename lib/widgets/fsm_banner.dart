import 'package:flutter/material.dart';
import 'package:mprc/helper/responsive_widget.dart';

import '../helper/styles.dart';
import 'corousal_slider/carousel_slider.dart';

class FSMBanner extends StatelessWidget {
  const FSMBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double containerHeight = ResponsiveWidget.isLargeScreen(context)
        ? 50
        : ResponsiveWidget.isMediumScreen(context)
            ? 30
            : 25;

    double viewport = ResponsiveWidget.isLargeScreen(context)
        ? 0.09
        : ResponsiveWidget.isMediumScreen(context)
            ? 0.19
            : 0.23;
    return Container(
      height: containerHeight,
      width: width(context),
      color: Colors.white,
      alignment: Alignment.center,
      child: CarouselSlider(
        items: List.generate(
          20,
          (index) => Image.asset(
            "asset/logo.jpg",
            height: containerHeight * 0.9,
          ),
        ),
        options: CarouselOptions(
          height: containerHeight * 0.9,
          autoPlay: true,
          viewportFraction: viewport,
          autoPlayInterval: Duration(
            milliseconds: 1600,
          ),
          autoPlayAnimationDuration: Duration(
            milliseconds: 1600,
          ),
          autoPlayCurve: Curves.linear,
        ),
      ),
    );
  }
}
