import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/coin_details/presentation/views/coin_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc get getBloc => context.read<HomeBloc>();

  @override
  void initState() {
    print("initState");
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
                const Column(children: [Text("Total Balance"), Text("\$1000")]),
                PrimaryButton(text: "Add Coin", onPressed: () {}),
              ],
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [Text("Total Balance"), Text("\$1000")]),
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
