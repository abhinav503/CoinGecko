import 'package:coingecko/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:coingecko/feature/home/presentation/view/home_page.dart';
import 'package:coingecko/core/di/injection_container.dart';

void main() async {
  injectionContainer();
  runApp(
    MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        textTheme: textTheme(),
        cardColor: greenShade400,
        scaffoldBackgroundColor: whiteColor,
        indicatorColor: greyColor,
      ),
    ),
  );
}

TextTheme textTheme() {
  String fontFamily = "Agdasima";
  return TextTheme(
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: fontFamily,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
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
