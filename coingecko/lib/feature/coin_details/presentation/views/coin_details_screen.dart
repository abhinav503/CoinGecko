import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key});

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
  CoinDetailsBloc get getBloc => context.read<CoinDetailsBloc>();

  @override
  void initState() {
    // getBloc.add(GetCoinDetailsEvent(id: "bitcoin"));
    getBloc.add(GetCoinMarketDataEvent(id: "bitcoin"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
