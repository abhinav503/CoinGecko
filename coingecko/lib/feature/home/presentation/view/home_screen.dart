import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/coin_details/presentation/views/coin_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get getBloc => context.read<HomeBloc>();

  @override
  void initState() {
    getBloc.add(FetchMarketCoinsEvent());
    getBloc.paginationScrollController.init(loadAction: _onNextPageCall);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          StringConstants.totalBalance,
                          style: Theme.of(
                            context,
                          ).textTheme.titleSmall!.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(width: 5),
                        const CustomIconWidget(
                          icon: HugeIcons.strokeRoundedMoneyExchange03,
                          color: Colors.green,
                          size: 15.0,
                        ),
                      ],
                    ),
                    Text(
                      "\$107,39.12",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
                PrimaryButton(text: StringConstants.deposit, onPressed: () {}),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New User Zone",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Get 100 USD bonus on your \nfirst deposit",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CustomIconWidget(
                    icon: HugeIcons.strokeRoundedAiNetwork,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Flexible(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is FetchMarketCoinsState) {
                  getBloc.paginationScrollController.isLoading = false;
                }
              },
              builder: (context, state) {
                if (getBloc.marketCoins.isEmpty) {
                  return _buildEmptyObject();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: getBloc.marketCoins.length,
                  controller:
                      getBloc.paginationScrollController.scrollController,
                  itemBuilder: (context, index) {
                    return CoinItemWidget(
                      coin: getBloc.marketCoins[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CoinDetailsPage(),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildEmptyObject() => const SizedBox.shrink();

  _onNextPageCall() async {
    getBloc.paginationScrollController.isLoading = true;
    getBloc.add(FetchMarketCoinsEvent());
  }
}
