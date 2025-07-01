import 'package:coingecko/core/base/base_screen.dart';
import 'package:coingecko/core/ui/molecules/coin_item_widget.dart';
import 'package:coingecko/feature/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends BaseScreen {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends BaseScreenState<FavouritesScreen> {
  late final FavouritesBloc favouritesBloc;

  @override
  void initState() {
    super.initState();
    favouritesBloc = BlocProvider.of<FavouritesBloc>(context);
    favouritesBloc.add(GetFavouritesEvent());
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: favouritesBloc.coins.length,
            itemBuilder: (context, index) {
              return CoinItemWidget(
                key: Key(
                  "coin_item_widget_favourites_screen_${favouritesBloc.coins[index].id}",
                ),
                coin: favouritesBloc.coins[index],
                onTapBookmark: () {
                  favouritesBloc.add(
                    AddFavouritesEvent(favouritesBloc.coins[index]),
                  );
                },
                onTap: () async {},
              );
            },
          ),
        );
      },
    );
  }
}
