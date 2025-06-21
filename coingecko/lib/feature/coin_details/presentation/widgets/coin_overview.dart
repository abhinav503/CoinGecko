import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/molecules/info_tile.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CoinOverview extends StatefulWidget {
  final MarketCoinEntity coinItemEntity;
  final TabController tabController;
  final double? width;
  const CoinOverview({
    super.key,
    required this.coinItemEntity,
    required this.tabController,
    this.width,
  });

  @override
  State<CoinOverview> createState() => _CoinOverviewState();
}

class _CoinOverviewState extends State<CoinOverview>
    with SingleTickerProviderStateMixin {
  bool isDescriptionExpanded = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = widget.tabController;
  }

  @override
  void dispose() {
    // Don't dispose the tabController here as it's passed from parent
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget mainDataWidget = Column(
      children: [
        InfoTile(
          leading: HugeIcons.strokeRoundedRanking,
          title: StringConstants.rank,
          trailing: widget.coinItemEntity.marketCapRank.toString(),
        ),
        InfoTile(
          leading: HugeIcons.strokeRoundedPresentationBarChart01,
          title: StringConstants.marketCap,
          trailingWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${(widget.coinItemEntity.marketCap! / 10000000).toStringAsFixed(2)} Cr",
                style:
                    kIsWeb
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                " (${widget.coinItemEntity.priceChangePercentage24h!}%)",
                style:
                    kIsWeb
                        ? Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              widget.coinItemEntity.marketCap! > 0
                                  ? AppColors.successColor
                                  : AppColors.errorColor,
                          fontWeight: FontWeight.bold,
                        )
                        : Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              widget.coinItemEntity.marketCap! > 0
                                  ? AppColors.successColor
                                  : AppColors.errorColor,
                          fontWeight: FontWeight.bold,
                        ),
              ),
            ],
          ),
        ),
        InfoTile(
          title: StringConstants.totalSupply,
          trailing:
              "${(widget.coinItemEntity.totalSupply! / 1000000).toStringAsFixed(2)} M",
          leading: HugeIcons.strokeRoundedDatabase,
        ),
      ],
    );
    Widget mainWidget = Container(
      padding: EdgeInsets.only(top: 20.h),
      height: kIsWeb ? MediaQuery.of(context).size.height - 190.h : 300.h,
      width: widget.width,
      child: TabBarView(
        controller: _tabController,
        children: [
          kIsWeb
              ? SingleChildScrollView(child: mainDataWidget)
              : mainDataWidget,
          const Text(StringConstants.myInvestments),
        ],
      ),
    );

    return mainWidget;
  }
}
