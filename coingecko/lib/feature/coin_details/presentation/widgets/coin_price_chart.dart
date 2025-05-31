import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/core/ui/atoms/primary_chip.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinPriceChart extends StatefulWidget {
  final CoinMarketDataEntity marketData;
  final String id;
  final MarketChartTimeFilter selectedFilter;
  final double height;
  final TextStyle? tooltipTextStyle;
  final Function(MarketChartTimeFilter, String) onFilterChanged;

  const CoinPriceChart({
    super.key,
    required this.marketData,
    required this.id,
    required this.selectedFilter,
    required this.onFilterChanged,
    this.height = 220,
    this.tooltipTextStyle,
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
            height: widget.height,
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
            return PrimaryChip(
              onTap: () => widget.onFilterChanged(filter, widget.id),
              text: filter.value,
              isSelected: isSelected,
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
                    widget.tooltipTextStyle ??
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
      ),
    );
  }
}
