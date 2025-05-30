import 'package:coingecko/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:coingecko/feature/home/presentation/view/home_page.dart';
import 'package:coingecko/core/di/injection_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  injectionContainer();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            home: const HomePage(),
            theme: ThemeData(
              textTheme: textTheme(),
              cardColor: greenShade400,
              scaffoldBackgroundColor: whiteColor,
              indicatorColor: greyColor,
            ),
          ),
    ),
  );
}

TextTheme textTheme() {
  String fontFamily = "Agdasima";
  return TextTheme(
    displayLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: fontFamily,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
    ),
    titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
    ),
  );
}
