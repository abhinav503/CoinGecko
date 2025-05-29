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
    // getBloc.paginationScrollController.init(loadAction: _onNextPageCall);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   child: CustomTextField(
          //     key: const Key("HomeTextField"),
          //     controller: getBloc.searchController,
          //     hintText: searchDadJokes,
          //     onChanged: _onChangedText,
          //   ),
          // ),
          // BlocBuilder<HomeBloc, HomeState>(
          //   buildWhen:
          //       (previous, current) => current is FetchSingleDadJokeState,
          //   builder: (context, state) {
          //     if (state is FetchSingleDadJokeState) {
          //       return JokeItemWidget(joke: state.dadJokeEntity?.joke ?? "");
          //     }
          //     return const LoadingWidget();
          //   },
          // ),
          Flexible(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // if (state is FetchSearchResultsState) {
                //   getBloc.paginationScrollController.isLoading = false;
                // } else if (state is FetchErrorState) {
                //   FocusScope.of(context).unfocus();
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(content: Text(state.apiFailureModel.message)),
                //   );
                // }
              },
              builder: (context, state) {
                if (getBloc.searchController.text.isEmpty) {
                  return _buildEmptyObject();
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildEmptyObject() => const SizedBox.shrink();

  // void _onChangedText(text) {
  //   if (getBloc.debounce?.isActive ?? false) getBloc.debounce?.cancel();
  //   getBloc.debounce = Timer(const Duration(milliseconds: 500), () {
  //     getBloc.add(
  //       FetchSearchResultsEvent(term: text, page: 1, isNewSearch: true),
  //     );
  //   });
  // }

  // _onNextPageCall() async {
  //   int lastPage = getBloc.searchDadJokeResultsEntity?.totalPages ?? 1;
  //   int currentPage = getBloc.searchDadJokeResultsEntity?.currentPage ?? 1;
  //   getBloc.paginationScrollController.currentPage = currentPage;
  //   if (lastPage > currentPage) {
  //     getBloc.paginationScrollController.isLoading = true;
  //     getBloc.add(
  //       FetchSearchResultsEvent(
  //         term: getBloc.searchController.text,
  //         limit: getBloc.limit,
  //         page: currentPage + 1,
  //       ),
  //     );
  //   } else if (lastPage == currentPage) {
  //     return true;
  //   }
  // }
}
