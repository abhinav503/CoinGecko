import 'package:coingecko/core/services/shared_preference/shared_preference_service.dart';
import 'package:coingecko/core/services/shared_preference/shared_preference_service_impl.dart';
import 'package:coingecko/feature/coin_details/data/data_source/coin_details_data_source_repository.dart';
import 'package:coingecko/feature/coin_details/data/data_source/coin_details_data_source_repository_impl.dart';
import 'package:coingecko/feature/coin_details/data/repository_impl/coin_details_repository_impl.dart';
import 'package:coingecko/feature/coin_details/domain/repository/coin_details_repository.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_market_data_usecase.dart';
import 'package:coingecko/feature/favourites/data/data_source/local_favourites_data_source.dart';
import 'package:coingecko/feature/favourites/data/data_source/local_favourites_data_source_impl.dart';
import 'package:coingecko/feature/favourites/data/repository_impl/favourites_repo_impl.dart';
import 'package:coingecko/feature/favourites/domain/repository/favourites_repository.dart';
import 'package:coingecko/feature/favourites/domain/usecase/get_favourites_usecase.dart';
import 'package:coingecko/feature/favourites/domain/usecase/set_favourites_usecase.dart';
import 'package:coingecko/feature/mobile_home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/mobile_home/data/data_source/home_data_source_repository_impl.dart';
import 'package:coingecko/feature/mobile_home/data/repository_impl/home_repository_impl.dart';
import 'package:coingecko/feature/mobile_home/domain/repository/home_repository.dart';
import 'package:coingecko/feature/mobile_home/domain/usecase/get_market_coins_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/core/network_repository/network_repository_impl.dart';

final sl = GetIt.instance;

Future<void> injectionContainer() async {
  sl.registerLazySingleton<SharedPreferenceService>(
    () => SharedPreferenceServiceImpl(),
  );
  sl<SharedPreferenceService>().init();

  sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());

  sl.registerLazySingleton<HomeDataSourceRepository>(
    () => HomeDataSourceRepositoryImpl(networkRepository: sl()),
  );

  sl.registerLazySingleton<LocalFavouritesDataSource>(
    () => LocalFavouritesDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<CoinDetailsDataSource>(
    () => CoinDetailsDataSourceImpl(networkRepository: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDataSourceRepository: sl()),
  );

  sl.registerLazySingleton<FavouritesRepository>(
    () => FavouritesRepoImpl(localFavouritesDataSource: sl()),
  );

  sl.registerLazySingleton<CoinDetailsRepository>(
    () => CoinDetailsRepositoryImpl(coinDetailsDataSource: sl()),
  );

  sl.registerLazySingleton<GetMarketCoinsUsecase>(
    () => GetMarketCoinsUsecase(homeRepository: sl()),
  );

  sl.registerLazySingleton<GetCoinMarketDataUsecase>(
    () => GetCoinMarketDataUsecase(coinDetailsRepository: sl()),
  );

  sl.registerLazySingleton<GetFavouritesUsecase>(
    () => GetFavouritesUsecase(sl()),
  );

  sl.registerLazySingleton<SetFavouritesUsecase>(
    () => SetFavouritesUsecase(sl()),
  );
}
