import 'package:flutter/material.dart';

enum ScreenType { mobileSmall, mobileLarge, tablet, desktop }

extension ScreenTypeExtension on ScreenType {
  ScreenType getDeviceType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width >= 1800) return ScreenType.desktop;
    if (width >= 1200) return ScreenType.tablet;
    if (width >= 900) return ScreenType.mobileLarge;
    return ScreenType.mobileSmall;
  }
}
