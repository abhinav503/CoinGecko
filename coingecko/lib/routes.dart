import 'package:coingecko/feature/coin_details/presentation/views/coin_details_page.dart';
import 'package:coingecko/feature/home/presentation/view/home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = "/home";
  static const String coinDetails = "/coin-details";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: RouteSettings(name: home, arguments: settings.arguments),
        );
      case coinDetails:
        return MaterialPageRoute(
          builder: (context) => const CoinDetailsPage(),
          settings: RouteSettings(
            name: coinDetails,
            arguments: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
          settings: RouteSettings(name: home, arguments: settings.arguments),
        );
    }
  }
}
