import 'package:coingecko/feature/home/domain/entities/market_coin_entity.dart';
import 'package:flutter/material.dart';

class CoinItemWidget extends StatelessWidget {
  final MarketCoinEntity coin;
  final VoidCallback onTap;
  const CoinItemWidget({super.key, required this.coin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Image.network(coin.image ?? ""),
      title: Text(coin.name ?? ""),
      subtitle: Text(coin.symbol ?? ""),
    );
  }
}
