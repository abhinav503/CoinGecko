import 'package:get_it/get_it.dart';
import 'package:coingecko/core/network_repository/network_repository.dart';
import 'package:coingecko/core/network_repository/network_repository_impl.dart';

final sl = GetIt.instance;

injectionContainer() {
  sl.registerLazySingleton<NetworkRepository>(() => NetworkRepositoryImpl());
}
