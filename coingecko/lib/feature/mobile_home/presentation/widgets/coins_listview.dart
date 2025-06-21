import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/feature/mobile_home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoinsListview extends StatelessWidget {
  final List<MarketCoinEntity> coins;
  final ScrollController? controller;
  final HomeBloc homeBloc;
  const CoinsListview({
    super.key,
    required this.coins,
    this.controller,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: coins.length,
      controller: controller,
      itemBuilder: (context, index) {
        return CoinItemWidget(
          key: Key("coin_item_widget_$index"),
          coin: coins[index],
          onTap: () async {
            if (kIsWeb) {
              Navigator.pushNamed(
                context,
                "${Routes.webCoinDetails}/${coins[index].id}",
                arguments: coins[index],
              );
            } else {
              homeBloc.stopTimer();
              await Navigator.pushNamed(
                context,
                Routes.coinDetails,
                arguments: coins[index],
              );
              homeBloc.startTimer();
            }
          },
        );
      },
    );
  }
}
