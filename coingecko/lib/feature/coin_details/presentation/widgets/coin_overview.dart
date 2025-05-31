import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/atoms/primary_text_button.dart';
import 'package:coingecko/core/ui/molecules/info_tile.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_item_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class CoinOverview extends StatefulWidget {
  final CoinItemEntity coinItemEntity;
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

class _CoinOverviewState extends State<CoinOverview> {
  bool isDescriptionExpanded = false;

  void _toggleDescription() {
    setState(() {
      isDescriptionExpanded = !isDescriptionExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget expandedDescriptionWidget = Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.coinItemEntity.description!,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: isDescriptionExpanded ? null : 3,
            overflow: isDescriptionExpanded ? null : TextOverflow.ellipsis,
          ),
          if (widget.coinItemEntity.description!.length > 150)
            PrimaryTextButton(
              onPressed: _toggleDescription,
              text:
                  isDescriptionExpanded
                      ? StringConstants.showLess
                      : StringConstants.showMore,
            ),
        ],
      ),
    );
    Widget mainDataWidget = Column(
      children: [
        if (!kIsWeb) expandedDescriptionWidget,
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
          title: StringConstants.totalVolume,
          trailing:
              "${(widget.coinItemEntity.totalVolume! / 1000000).toStringAsFixed(2)} M",
          leading: HugeIcons.strokeRoundedDatabase,
        ),
        if (kIsWeb) expandedDescriptionWidget,
      ],
    );
    Widget mainWidget = Container(
      padding: EdgeInsets.only(top: 20.h),
      height:
          kIsWeb
              ? MediaQuery.of(context).size.height - 180.h
              : isDescriptionExpanded
              ? (widget.coinItemEntity.description!.length / 250) * 200
              : 300.h,
      width: widget.width,
      child: TabBarView(
        controller: widget.tabController,
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
