import 'package:coingecko/core/enums/market_chart_time_filter.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  CoinDetailsBloc get getBloc => context.read<CoinDetailsBloc>();

  @override
  void initState() {
    getBloc.add(GetCoinDetailsEvent(id: "bitcoin"));
    getBloc.add(GetCoinMarketDataEvent(id: "bitcoin"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
      builder: (context, state) {
        if (getBloc.coinItemEntity == null ||
            getBloc.coinMarketDataEntity == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              "\$${getBloc.coinItemEntity?.currentPrice.toString() ?? ""}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getBloc.coinItemEntity!.priceChange24h! > 0
                        ? "+\$${getBloc.coinItemEntity?.priceChange24h.toString() ?? ""}"
                        : "-\$${getBloc.coinItemEntity?.priceChange24h.toString().substring(1) ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color:
                          getBloc.coinItemEntity!.priceChange24h! > 0
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    indent: 10.h,
                    endIndent: 10.h,
                  ),
                  if (getBloc.coinItemEntity!.priceChangePercentage24h != null)
                    Text(
                      "${getBloc.coinItemEntity!.priceChangePercentage24h! > 0 ? "+" : ""} ${getBloc.coinItemEntity?.priceChangePercentage24h.toString() ?? ""} %",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            getBloc.coinItemEntity!.priceChangePercentage24h! >
                                    0
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  VerticalDivider(
                    color: Colors.grey,
                    indent: 10.h,
                    endIndent: 10.h,
                  ),
                  Text(
                    getBloc.currentFilter.titleValue,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
