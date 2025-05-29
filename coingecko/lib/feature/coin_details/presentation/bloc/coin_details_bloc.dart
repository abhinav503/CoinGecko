import 'package:bloc/bloc.dart';
import 'package:coingecko/feature/coin_details/domain/entities/coin_details_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/entities/get_coin_market_data_req_entity.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_details_usecase.dart';
import 'package:coingecko/feature/coin_details/domain/usecase/get_coin_market_data_usecase.dart';
import 'package:meta/meta.dart';

part 'coin_details_event.dart';
part 'coin_details_state.dart';

class CoinDetailsBloc extends Bloc<CoinDetailsEvent, CoinDetailsState> {
  final GetCoinDetailsUsecase getCoinDetailsUsecase;
  final GetCoinMarketDataUsecase getCoinMarketDataUsecase;
  CoinDetailsBloc({
    required this.getCoinDetailsUsecase,
    required this.getCoinMarketDataUsecase,
  }) : super(CoinDetailsInitial()) {
    on<CoinDetailsEvent>((event, emit) {});

    on<GetCoinDetailsEvent>((event, emit) async {
      final result = await getCoinDetailsUsecase(
        CoinDetailsReqEntity(id: event.id),
      );
      result.fold(
        (failure) {
          print(failure);
          // emit(CoinDetailsApiCallState());
        },
        (data) {
          emit(CoinDetailsApiCallState());
        },
      );
    });

    on<GetCoinMarketDataEvent>((event, emit) async {
      final result = await getCoinMarketDataUsecase(
        GetCoinMarketDataReqEntity(id: event.id, vsCurrency: "usd", days: "30"),
      );
      result.fold(
        (failure) {
          print(failure);
        },
        (data) {
          print(data.prices);
          emit(CoinMarketDataApiCallState());
        },
      );
    });
  }
}
