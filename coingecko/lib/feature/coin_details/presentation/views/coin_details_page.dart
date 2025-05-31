import 'package:coingecko/core/base/base_page.dart';
import 'package:coingecko/core/di/injection_container.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/views/coin_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetailsPage extends BasePage {
  const CoinDetailsPage({super.key});

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends BasePageState<CoinDetailsPage> {
  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create:
          (context) => CoinDetailsBloc(
            getCoinDetailsUsecase: sl(),
            getCoinMarketDataUsecase: sl(),
          ),
      child: CoinDetailsScreen(id: arguments),
    );
  }
}
