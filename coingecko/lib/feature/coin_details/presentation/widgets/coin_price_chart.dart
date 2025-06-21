import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/core/ui/atoms/primary_chip.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:coingecko/feature/mobile_home/domain/entities/market_coin_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CoinPriceChart extends StatefulWidget {
  final CoinMarketDataEntity marketData;
  final MarketCoinEntity coin;
  final String id;
  final MarketChartTimeFilter selectedFilter;
  final double height;
  final TextStyle? tooltipTextStyle;
  final EdgeInsets? padding;
  final bool isLoading;
  final Function(MarketChartTimeFilter, String) onFilterChanged;

  const CoinPriceChart({
    super.key,
    required this.marketData,
    required this.id,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.height = 220,
    this.tooltipTextStyle,
    this.padding,
    required this.coin,
    this.isLoading = false,
  });

  @override
  State<CoinPriceChart> createState() => _CoinPriceChartState();
}

class _CoinPriceChartState extends State<CoinPriceChart> {
  int? currentXValue;
  double? currentYValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: widget.height,
                child:
                    widget.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : LineChart(_createLineChartData(context)),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  height: 50.h,
                  color: AppColors.primaryColorLight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        widget.coin.name ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          _buildFilterButtons(context),
        ],
      ),
    );
  }

  Widget _buildFilterButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
          MarketChartTimeFilter.values.map((filter) {
            final isSelected = filter == widget.selectedFilter;
            return PrimaryChip(
              onTap: () => widget.onFilterChanged(filter, widget.id),
              text: filter.value,
              isSelected: isSelected,
              width: kIsWeb ? 100.w : null,
            );
          }).toList(),
    );
  }

  LineChartData _createLineChartData(BuildContext context) {
    final priceData = widget.marketData.prices ?? [];
    final spots =
        priceData.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.value ?? 0);
        }).toList();
    var minY =
        spots.isEmpty
            ? 0
            : spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b);
    var maxY =
        spots.isEmpty
            ? 0
            : spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    if (minY == maxY) {
      minY = 0;
    }
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.transparent, strokeWidth: 0);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color:
                currentXValue == value.toInt()
                    ? AppColors.primaryColor.withOpacity(0.3)
                    : Colors.transparent,
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: AppColors.primaryColor,
          barWidth: 2,
          curveSmoothness: 0,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
        ),
      ],
      minY: minY.toDouble(),
      maxY: maxY.toDouble(),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          showOnTopOfTheChartBoxArea: true,
          tooltipRoundedRadius: 8,
          tooltipHorizontalOffset: -10.w,
          tooltipPadding: EdgeInsets.only(
            left: 8.w,
            right: 8.w,
            top: 8.h,
            bottom: 0.h,
          ),
          tooltipHorizontalAlignment: FLHorizontalAlignment.left,
          // tooltipMargin: 10.w,
          tooltipBgColor: Colors.transparent,
          tooltipBorder: const BorderSide(color: Colors.transparent),
          getTooltipItems: (touchedSpots) {
            return touchedSpots
                .map(
                  (spot) => LineTooltipItem(
                    spot.x.toInt() < (widget.marketData.prices?.length ?? 0)
                        ? getTooltipPriceText(spot.y)
                        : "",
                    widget.tooltipTextStyle ??
                        const TextStyle(
                          color: AppColors.primaryTextColorLight,
                          fontSize: 12,
                        ),
                    children: [
                      TextSpan(
                        text:
                            spot.x.toInt() <
                                    (widget.marketData.prices?.length ?? 0)
                                ? getTooltipDateText(spot.x.toInt())
                                : "",
                        style:
                            widget.tooltipTextStyle ??
                            const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                )
                .toList();
          },
          fitInsideVertically: false,
          fitInsideHorizontally: true,
        ),
        touchCallback: (touch, response) {
          if (touch is FlPanEndEvent || touch is FlTapUpEvent) {
            setState(() {
              currentXValue = null;
            });
          } else if (response?.lineBarSpots != null &&
              response!.lineBarSpots!.isNotEmpty) {
            setState(() {
              currentXValue = response.lineBarSpots!.first.x.toInt();
            });
          }
        },
      ),
    );
  }

  getTooltipPriceText(double y) {
    return "\$ ${y.toStringAsFixed(2)}\n";
  }

  getTooltipDateText(int x) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      widget.marketData.prices?[x].timestamp ?? 0,
    );
    return DateFormat('MMM d, yyyy').format(date);
  }
}
