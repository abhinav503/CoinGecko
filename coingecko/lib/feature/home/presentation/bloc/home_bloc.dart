import 'dart:async';
import 'package:coingecko/core/ui/atoms/pagination_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isLoading = false;
  int limit = 20;
  Timer? debounce;
  PaginationScrollController paginationScrollController =
      PaginationScrollController();

  TextEditingController searchController = TextEditingController();
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>((event, emitState) {});
  }
  @override
  Future<void> close() {
    paginationScrollController.dispose();
    debounce?.cancel();
    return super.close();
  }
}
