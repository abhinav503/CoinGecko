import 'package:coingecko/core/constants/currency_constants.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:coingecko/core/di/injection_container.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectionContainer();
  if (!args.contains("testEnv")) {
    runApp(const MainApp());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: kIsWeb ? const Size(1920, 1080) : const Size(375, 812),
      minTextAdapt: true,
      builder:
          (context, child) => MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: CurrencyConstants.getSupportedLocales(),
            onGenerateRoute:
                kIsWeb ? Routes.generateRouteWeb : Routes.generateRouteMobile,
            theme: ThemeData(textTheme: textTheme()),
          ),
    );
  }
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
    bodySmall: TextStyle(fontSize: 14, fontFamily: fontFamily),
  );
}
