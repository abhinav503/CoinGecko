import 'package:coingecko/core/base/base_page.dart';
import 'package:coingecko/core/di/injection_container.dart';
import 'package:coingecko/feature/favourites/domain/usecase/get_favourites_usecase.dart';
import 'package:coingecko/feature/favourites/domain/usecase/set_favourites_usecase.dart';
import 'package:coingecko/feature/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:coingecko/feature/favourites/presentation/views/favourites_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends BasePage {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends BasePageState<FavouritesPage> {
  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create:
          (context) => FavouritesBloc(
            getFavouritesUsecase: sl<GetFavouritesUsecase>(),
            setFavouritesUsecase: sl<SetFavouritesUsecase>(),
          ),
      child: const FavouritesScreen(),
    );
  }
}
