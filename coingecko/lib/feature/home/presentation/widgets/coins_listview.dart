import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:coingecko/routes.dart';
import 'package:flutter/foundation.dart';
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
            print("onTap: ${coins[index].id} ${kIsWeb}");
            if (kIsWeb) {
              Navigator.pushNamed(
                context,
                "${Routes.webCoinDetails}/${coins[index].id}",
                arguments: coins[index].id,
              );
            } else {
              Navigator.pushNamed(
                context,
                Routes.coinDetails,
                arguments: coins[index].id,
              );
            }
          },
        );
      },
    );
  }
}
