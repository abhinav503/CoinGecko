import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_market_data_entity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinPriceChart extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 220.h, child: LineChart(_createLineChartData())),
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
            final isSelected = filter == selectedFilter;
            return InkWell(
              onTap: () => onFilterChanged(filter),
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

  LineChartData _createLineChartData() {
    final priceData = marketData.prices ?? [];
    final spots =
        priceData.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value.value ?? 0);
        }).toList();

    return LineChartData(
      gridData: const FlGridData(show: false),
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
    );
  }
}
