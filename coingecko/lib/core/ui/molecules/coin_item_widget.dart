import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:flutter/material.dart';

class CoinItemWidget extends StatelessWidget {
  final MarketCoinEntity coin;
  final VoidCallback onTap;
  const CoinItemWidget({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading: CustomNetworkImage(imageUrl: coin.image ?? ""),
      title: Text(
        coin.name ?? "",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        (coin.symbol ?? "").toUpperCase(),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${coin.priceChangePercentage24h! > 0 ? "+" : ""}${coin.priceChangePercentage24h}%",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:
                  coin.priceChangePercentage24h! > 0
                      ? Colors.green
                      : Colors.red,
            ),
          ),
          Text(
            "\$${coin.currentPrice}",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
