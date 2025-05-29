import 'package:coingecko/feature/home/data/data_source/home_data_source_repository.dart';
import 'package:coingecko/feature/home/data/data_source/home_data_source_repository_impl.dart';
import 'package:coingecko/feature/home/data/repository_impl/home_repository_impl.dart';
import 'package:coingecko/feature/home/domain/repository/home_repository.dart';
import 'package:coingecko/feature/home/domain/usecase/get_market_coins_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/core/network_repository/network_repository_impl.dart';

final sl = GetIt.instance;

injectionContainer() {
  sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());

  sl.registerLazySingleton<HomeDataSourceRepository>(
    () => HomeDataSourceRepositoryImpl(networkRepository: sl()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeDataSourceRepository: sl()),
  );

  sl.registerLazySingleton<GetMarketCoinsUsecase>(
    () => GetMarketCoinsUsecase(homeRepository: sl()),
  );
}
