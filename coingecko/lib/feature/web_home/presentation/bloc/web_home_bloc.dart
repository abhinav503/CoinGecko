import 'package:bloc/bloc.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:coingecko/feature/mobile_home/presentation/bloc/home_bloc.dart';
import 'package:meta/meta.dart';

part 'web_home_event.dart';
part 'web_home_state.dart';

class WebHomeBloc extends Bloc<WebHomeEvent, WebHomeState> {
  int selectedIndex = 0;
  WebHomeBloc(HomeBloc homeBloc, CoinDetailsBloc coinDetailsBloc)
    : super(WebHomeInitial()) {
    on<WebHomeEvent>((event, emit) {});
    on<SelectCoinEvent>((event, emit) {
      selectedIndex = event.index;
      coinDetailsBloc.add(
        ChangeCoinDetailsEvent(coin: homeBloc.marketCoins[selectedIndex]),
      );
      emit(SelectedCoinState(runApis: event.runApis));
    });
  }
}
