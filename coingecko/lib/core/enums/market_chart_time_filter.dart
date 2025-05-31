enum MarketChartTimeFilter { oneDay, oneWeek, oneMonth, oneYear }

extension MarketChartTimeFilterExtension on MarketChartTimeFilter {
  String get value {
    switch (this) {
      case MarketChartTimeFilter.oneDay:
        return "1D";
      case MarketChartTimeFilter.oneWeek:
        return "1W";
      case MarketChartTimeFilter.oneMonth:
        return "1M";
      case MarketChartTimeFilter.oneYear:
        return "1Y";
    }
  }

  int get days {
    switch (this) {
      case MarketChartTimeFilter.oneDay:
        return 1;
      case MarketChartTimeFilter.oneWeek:
        return 7;
      case MarketChartTimeFilter.oneMonth:
        return 30;
      case MarketChartTimeFilter.oneYear:
        return 365;
    }
  }

  String? get interval {
    switch (this) {
      case MarketChartTimeFilter.oneYear:
        return "daily";
      default:
        return null;
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
