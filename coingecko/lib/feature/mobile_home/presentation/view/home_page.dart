import 'package:coingecko/core/base/base_page.dart';
import 'package:coingecko/feature/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:coingecko/feature/mobile_home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/mobile_home/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coingecko/core/di/injection_container.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  @override
  Widget body(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(getMarketCoinsUsecase: sl()),
        ),
        BlocProvider(
          create:
              (context) => FavouritesBloc(
                getFavouritesUsecase: sl(),
                setFavouritesUsecase: sl(),
              ),
        ),
      ],
      child: const HomeScreen(),
    );
  }
}
