enum MarketChartTimeFilter { oneDay, oneWeek, oneMonth, oneYear }

extension MarketChartTimeFilterExtension on MarketChartTimeFilter {
  String get value {
    switch (this) {
      case MarketChartTimeFilter.oneDay:
        return "24h";
      case MarketChartTimeFilter.oneWeek:
        return "7d";
      case MarketChartTimeFilter.oneMonth:
        return "30d";
      case MarketChartTimeFilter.oneYear:
        return "1y";
    }
  }

  String get titleValue {
    switch (this) {
      case MarketChartTimeFilter.oneDay:
        return "Past 1 day";
      case MarketChartTimeFilter.oneWeek:
        return "Past 1 week";
      case MarketChartTimeFilter.oneMonth:
        return "Past 1 month";
      case MarketChartTimeFilter.oneYear:
        return "Past 1 year";
    }
  }
}
