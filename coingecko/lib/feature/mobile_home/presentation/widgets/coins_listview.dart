import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CoinsListview extends StatelessWidget {
  final List<MarketCoinEntity> coins;
  final ScrollController? controller;
  const CoinsListview({super.key, required this.coins, this.controller});

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
          onTap: () {
            if (kIsWeb) {
              Navigator.pushNamed(
                context,
                "${Routes.webCoinDetails}/${coins[index].id}",
                arguments: coins[index],
              );
            } else {
              Navigator.pushNamed(
                context,
                Routes.coinDetails,
                arguments: coins[index],
              );
            }
          },
        );
      },
    );
  }
}
