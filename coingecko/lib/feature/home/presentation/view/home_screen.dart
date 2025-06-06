import 'package:coingecko/core/base/base_screen.dart';
import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/constants/string_constants.dart';
import 'package:coingecko/core/ui/atoms/carousel_slider_widget.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:coingecko/core/ui/atoms/primary_button.dart';
import 'package:coingecko/core/ui/molecules/campaign_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_tabbar.dart';
import 'package:coingecko/feature/home/presentation/widgets/coins_listview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen>
    with TickerProviderStateMixin {
  HomeBloc get getBloc => context.read<HomeBloc>();

  @override
  void initState() {
    getBloc.tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: getBloc.currentTabIndex,
    );
    getBloc.add(FetchMarketCoinsEvent(order: getBloc.currentOrder));
    getBloc.paginationScrollController.init(loadAction: getBloc.onNextPageCall);
    super.initState();
  }

  @override
  void dispose() {
    getBloc.tabController?.dispose();
    super.dispose();
  }

  @override
  Widget body(BuildContext context) {
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
                const Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          StringConstants.totalBalance,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(width: 5),
                        CustomIconWidget(
                          icon: HugeIcons.strokeRoundedMoneyExchange03,
                          color: Colors.green,
                          size: 15.0,
                        ),
                      ],
                    ),
                    Text(
                      "\$107,39.12",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                PrimaryButton(text: StringConstants.deposit, onPressed: () {}),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          const CarouselSliderWidget(
            height: 60,
            items: [
              CampaignWidget(
                icon: HugeIcons.strokeRoundedAiNetwork,
                color: Colors.red,
              ),
              CampaignWidget(
                icon: HugeIcons.strokeRoundedAiBrain02,
                color: Colors.blue,
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 10),
          Flexible(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is FetchMarketCoinsState) {
                  getBloc.paginationScrollController.isLoading = false;
                }
                if (state is FetchMarketCoinsErrorState) {
                  showToast(state.message);
                }
              },
              builder: (context, state) {
                if (getBloc.marketCoins.isEmpty) {
                  return _buildEmptyObject();
                }
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 12.w),
                        Text(
                          StringConstants.watchlist,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 30),
                        Text(
                          StringConstants.coin,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: kIsWeb ? 45.h : 35.h,
                      child: CustomTabbar(
                        onTap: getBloc.onTapMarketCoinsTab,
                        tabController: getBloc.tabController!,
                        tabs: const [
                          StringConstants.all,
                          StringConstants.totalVolume,
                        ],
                        onTabChanged: (index) {},
                        indicator: BoxDecoration(
                          color: AppColors.primaryTextColorLight.withOpacity(
                            0.4,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        indicatorPadding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 0,
                        ),
                        height: kIsWeb ? 45.h : 45.h,
                        textStyle:
                            kIsWeb
                                ? Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(fontSize: 12)
                                : null,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: TabBarView(
                        controller: getBloc.tabController,
                        children: [
                          CoinsListview(
                            coins: getBloc.marketCoins,
                            controller:
                                getBloc
                                    .paginationScrollController
                                    .scrollController,
                          ),
                          CoinsListview(
                            coins: getBloc.marketCoins,
                            controller:
                                getBloc
                                    .paginationScrollController
                                    .scrollController,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildEmptyObject() => const SizedBox.shrink();
}
