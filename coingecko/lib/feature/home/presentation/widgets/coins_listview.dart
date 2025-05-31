import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/material.dart';

class CoinsListview extends StatelessWidget {
  final List<MarketCoinEntity> coins;
  final ScrollController controller;
  const CoinsListview({
    super.key,
    required this.coins,
    required this.controller,
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
          coin: coins[index],
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.coinDetails,
              arguments: coins[index].id,
            );
          },
        );
      },
    );
  }
}
