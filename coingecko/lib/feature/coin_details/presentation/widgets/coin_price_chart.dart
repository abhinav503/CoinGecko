import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinPriceChart extends StatefulWidget {
  final CoinMarketDataEntity marketData;
  final MarketChartTimeFilter selectedFilter;
  final Function(MarketChartTimeFilter) onFilterChanged;

  const CoinPriceChart({
    super.key,
    required this.marketData,
    required this.selectedFilter,
    required this.onFilterChanged,
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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: 220.h,
            child: LineChart(_createLineChartData(context)),
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
            return InkWell(
              onTap: () => widget.onFilterChanged(filter),
              splashColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  filter.value,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? AppColors.primaryColor : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
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
      minY:
          spots.isEmpty
              ? 0
              : spots.map((spot) => spot.y).reduce((a, b) => a < b ? a : b),
      maxY:
          spots.isEmpty
              ? 0
              : spots.map((spot) => spot.y).reduce((a, b) => a > b ? a : b),

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
          tooltipMargin: 10.w,
          tooltipBgColor: Colors.transparent,
          tooltipBorder: const BorderSide(color: Colors.transparent),
          getTooltipItems: (touchedSpots) {
            return touchedSpots
                .map(
                  (spot) => LineTooltipItem(
                    "\$ ${spot.y.toStringAsFixed(2)}",
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.primaryTextColorLight,
                    ),
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
        // getTouchedSpotIndicator: (
        //   LineChartBarData barData,
        //   List<int> spotIndexes,
        // ) {
        //   return spotIndexes.map((index) {
        //     return TouchedSpotIndicatorData(
        //       FlLine(color: AppColors.primaryColor, strokeWidth: 2),
        //       FlDotData(
        //         show: true,
        //         getDotPainter:
        //             (spot, percent, barData, index) => FlRadioDotPainter(
        //               fillColor: AppColors.primaryColor,
        //               borderColor: AppColors.primaryColor,
        //               outerRadius: 9,
        //               innerRadius: 6.4,
        //             ),
        //       ),
        //     );
        //   }).toList();
        // },
      ),
    );
  }
}
