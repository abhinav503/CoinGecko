import 'package:coingecko/core/base/base_web_page.dart';
import 'package:coingecko/core/di/injection_container.dart';
import 'package:coingecko/core/ui/molecules/web_appbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/bloc/web_home_bloc.dart';
import 'package:coingecko/feature/web_home/presentation/views/web_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebHomePage extends BaseWebPage {
  const WebHomePage({super.key});

  @override
  State<WebHomePage> createState() => _WebHomePageState();
}

class _WebHomePageState extends BaseWebPageState<WebHomePage> {
  final homeBloc = HomeBloc(getMarketCoinsUsecase: sl());

  @override
  Widget body(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => CoinDetailsBloc(
                getCoinDetailsUsecase: sl(),
                getCoinMarketDataUsecase: sl(),
              ),
        ),
        BlocProvider(create: (context) => homeBloc),
        BlocProvider(create: (context) => WebHomeBloc(homeBloc)),
      ],
      child: WebHomeScreen(selectedCoin: arguments),
    );
  }

  @override
  PreferredSizeWidget? appBar() => WebAppbar(title: "Home", height: 100.h);
}
