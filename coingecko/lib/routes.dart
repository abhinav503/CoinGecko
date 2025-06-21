import 'package:coingecko/feature/coin_details/presentation/views/coin_details_page.dart';
import 'package:coingecko/feature/mobile_home/presentation/view/home_page.dart';
import 'package:coingecko/feature/web_home/presentation/views/web_home_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = "/home";
  static const String coinDetails = "/coinDetails";
  static const String webCoinDetails = "/coinDetails";
  static const String webHome = "/webHome";
  static Route<dynamic> generateRouteMobile(RouteSettings settings) {
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

  static Route<dynamic> generateRouteWeb(RouteSettings settings) {
    final uri = Uri.parse(settings.name!);
    if (uri.pathSegments.length == 2 && uri.pathSegments[0] == 'coinDetails') {
      return MaterialPageRoute(
        builder: (_) => const CoinDetailsPage(),
        settings: RouteSettings(
          name: "/coinDetails/${uri.pathSegments[1]}",
          arguments: settings.arguments,
        ),
      );
    }
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (context) => const WebHomePage(),
          settings: RouteSettings(name: webHome, arguments: settings.arguments),
        );
    }
  }
}
