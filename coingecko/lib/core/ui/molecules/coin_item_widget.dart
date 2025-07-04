import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/atoms/name_symbol_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_network_image.dart';
import 'package:coingecko/core/utils/price_formatter.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:flutter/material.dart';

class CoinItemWidget extends StatelessWidget {
  final MarketCoinEntity coin;
  final VoidCallback onTap;
  final bool isSelected;
  final bool showLeading;
  final VoidCallback? onTapBookmark;
  const CoinItemWidget({
    super.key,
    required this.coin,
    required this.onTap,
    this.isSelected = false,
    this.showLeading = true,
    this.onTapBookmark,
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
      title: NameSymbolWidget(
        symbol:
            (coin.name ?? "").length > 10
                ? "${(coin.name ?? "").substring(0, 10)}..."
                : (coin.name ?? ""),
        currency: (coin.symbol ?? "").toUpperCase(),
        textColor: AppColors.primaryTextColor,
      ),
      subtitle: Text(
        PriceFormatter.formatPrice(coin.marketCap, context: context),
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                PriceFormatter.formatPercentage(coin.priceChangePercentage24h),
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
          IconButton(
            onPressed: onTapBookmark,
            icon: const Icon(Icons.bookmark),
          ),
        ],
      ),
    );
  }
}
