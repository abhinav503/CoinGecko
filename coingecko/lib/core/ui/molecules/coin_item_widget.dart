import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:coingecko/core/utils/price_formatter.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:flutter/material.dart';

class CoinItemWidget extends StatelessWidget {
  final MarketCoinEntity coin;
  final VoidCallback onTap;
  final bool isSelected;
  final bool showLeading;
  const CoinItemWidget({
    super.key,
    required this.coin,
    required this.onTap,
    this.isSelected = false,
    this.showLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      onTap: onTap,
      leading:
          showLeading ? CustomNetworkImage(imageUrl: coin.image ?? "") : null,
      selectedTileColor: WebAppbarColors.selectedColor,
      selectedColor: WebAppbarColors.selectedColor,
      selected: isSelected,
      title: Text(
        coin.name ?? "",
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryTextColor,
        ),
      ),
      subtitle: Text(
        (coin.symbol ?? "").toUpperCase(),
        style: const TextStyle(fontSize: 12, color: AppColors.primaryTextColor),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "${coin.priceChangePercentage24h! > 0 ? "+" : ""}${coin.priceChangePercentage24h}%",
            style: TextStyle(
              color:
                  coin.priceChangePercentage24h! > 0
                      ? Colors.green
                      : Colors.red,
              fontSize: 15,
            ),
          ),
          Text(
            PriceFormatter.formatPrice(coin.currentPrice, context: context),
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
